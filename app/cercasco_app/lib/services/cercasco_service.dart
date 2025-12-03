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
  BluetoothCharacteristic? _ledCharacteristic;
  int _currentAlertLevel = 1;


  // Estado del escaneo
  bool _isScanning = false;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  // Getters públicos
  int get batteryLevel => _batteryLevel;
  bool get isConnected => _isConnected;
  bool get isScanning => _isScanning;
  int get currentAlertLevel => _currentAlertLevel;

  final String SERVICE_UUID = "0000180f-0000-1000-8000-00805f9b34fb"; // Ejemplo: Batería
  final String BATTERY_CHAR_UUID = "00002a19-0000-1000-8000-00805f9b34fb"; // Ejemplo: Nivel de Batería
  final String LED_CHAR_UUID = "0000180a-0000-1000-8000-00805f9b34fb"; // Ejemplo: Control de LED
  final String SENSOR_CHAR_UUID = "00002a58-0000-1000-8000-00805f9b34fb";
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
          // Aquí empieza el bucle que revisa cada característica
          for (var char in service.characteristics) {

            // 1. Configuración Batería
            if (char.uuid.toString() == BATTERY_CHAR_UUID) {
              await char.setNotifyValue(true);
              char.value.listen((value) {
                if (value.isNotEmpty) {
                  _batteryLevel = value[0];
                  notifyListeners();
                }
              });
            }

            // 2. Configuración LED
            if (char.uuid.toString() == LED_CHAR_UUID) {
              _ledCharacteristic = char;
              print(">>> Característica LED vinculada correctamente.");
            }

            // 3. NUEVO: Configuración Sensor de Alerta (AQUÍ ES DONDE DEBE IR)
            if (char.uuid.toString() == SENSOR_CHAR_UUID) {
              await char.setNotifyValue(true);
              char.value.listen((value) {
                if (value.isNotEmpty) {
                  int newLevel = value[0];
                  // Solo notificamos si el nivel cambió
                  if (_currentAlertLevel != newLevel) {
                    _currentAlertLevel = newLevel;
                    print(">>> ALERTA RECIBIDA NIVEL: $_currentAlertLevel"); // Log para depurar
                    notifyListeners(); // Esto avisará al Home
                  }
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
    if (_connectedDevice == null || !_isConnected || _ledCharacteristic == null) {
      print("No se puede cambiar color: Dispositivo desconectado o servicio no encontrado.");
      return;
    }

    List<int> colorBytes = [color.red, color.green, color.blue];

    try {
      print("Enviando color RGB: $colorBytes");
      await _ledCharacteristic!.write(colorBytes, withoutResponse: true);
    } catch (e) {
      print("Error enviando color: $e");
    }
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      print(">>> Desconectando manualmente...");
      await _connectedDevice!.disconnect();
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectedDevice?.disconnect();
    super.dispose();
  }
}