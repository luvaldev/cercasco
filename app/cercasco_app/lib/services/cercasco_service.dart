import 'dart:async';
import 'dart:io'; // Importado para Platform.isAndroid
import 'dart:ui'; // Para el tipo 'Color'
import 'package:flutter/foundation.dart'; // Para 'ChangeNotifier'
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class CercascoService with ChangeNotifier {
  BluetoothDevice? _connectedDevice;
  int _batteryLevel = 0;
  bool _isConnected = false;

  // Estado del escaneo
  bool _isScanning = false;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  // Getters públicos
  int get batteryLevel => _batteryLevel;
  bool get isConnected => _isConnected;
  bool get isScanning => _isScanning;

  final String SERVICE_UUID = "0000180f-0000-1000-8000-00805f9b34fb"; // Ejemplo: Batería
  final String BATTERY_CHAR_UUID = "00002a19-0000-1000-8000-00805f9b34fb"; // Ejemplo: Nivel de Batería
  final String LED_CHAR_UUID = "0000180a-0000-1000-8000-00805f9b34fb"; // Ejemplo: Control de LED
  // --------------------------------------------------

  CercascoService() {
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        scanForDevice();
      } else {
        _isConnected = false;
        _isScanning = false;
        _connectedDevice = null;
        notifyListeners();
      }
    });
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      var locationStatus = await Permission.location.request();
      var scanStatus = await Permission.bluetoothScan.request();
      var connectStatus = await Permission.bluetoothConnect.request();

      if (locationStatus.isGranted && scanStatus.isGranted && connectStatus.isGranted) {
        return true;
      }
    } else {
      var locationStatus = await Permission.location.request();
      if (locationStatus.isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<void> scanForDevice() async {
    if (_isScanning || _isConnected) return;

    var adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      print("[CercascoService] Error: Bluetooth está apagado.");
      return;
    }
    // -------------------------

    bool permissionsGranted = await _requestPermissions();
    if (!permissionsGranted) {
      print("[CercascoService] Error: Permisos de Localización y Bluetooth son requeridos.");
      return;
    }

    _isScanning = true;
    notifyListeners();

    _scanSubscription?.cancel();
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.platformName == "CercascoHub") {
          print(">>> Dispositivo 'CercascoHub' encontrado. Intentando conectar...");
          FlutterBluePlus.stopScan();
          connectToDevice(r.device);
          break;
        }
      }
    });

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      print("[CercascoService] Error al iniciar escaneo: $e");
      _isScanning = false;
      notifyListeners();
    }


    Future.delayed(const Duration(seconds: 15), () {
      if (_isScanning) {
        FlutterBluePlus.stopScan();
        _isScanning = false;
        notifyListeners();
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (_isConnected) return;

    if (_isScanning) {
      _isScanning = false;
      notifyListeners();
    }

    _connectionSubscription?.cancel();
    _connectionSubscription = device.connectionState.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        _isConnected = false;
        _connectedDevice = null;
        _batteryLevel = 0;
        notifyListeners();
        if (!_isScanning) {
          scanForDevice();
        }
      }
    });

    try {
      print(">>> Llamando a device.connect()...");
      await device.connect(
          autoConnect: false,
          timeout: const Duration(seconds: 15)
      );

      _connectedDevice = device;
      _isConnected = true;

      notifyListeners();
      await discoverServices();

    } catch (e) {
      print('!!!!!!!! ERROR AL CONECTAR: $e !!!!!!!!');
      _connectionSubscription?.cancel();
      _isConnected = false;

      notifyListeners();
      if (!_isScanning) {
        scanForDevice();
      }
    }
  }

  Future<void> discoverServices() async {
    if (_connectedDevice == null) return;

    try {
      List<BluetoothService> services = await _connectedDevice!.discoverServices();

      for (var service in services) {
        if (service.uuid.toString() == SERVICE_UUID) {
          for (var char in service.characteristics) {
            if (char.uuid.toString() == BATTERY_CHAR_UUID) {
              await char.setNotifyValue(true);
              char.value.listen((value) {
                if (value.isNotEmpty) {
                  _batteryLevel = value[0];
                  notifyListeners();
                }
              });
            }
          }
        }
      }
    } catch (e) {
      print('Error descubriendo servicios: $e');
    }
  }

  Future<void> setLedColor(Color color) async {
    if (_connectedDevice == null || !_isConnected) return;
    print("Simulación: Enviando color: $color");
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectedDevice?.disconnect();
    super.dispose();
  }
}