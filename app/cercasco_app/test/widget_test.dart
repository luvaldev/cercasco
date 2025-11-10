import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CercascoService with ChangeNotifier {
  BluetoothDevice? _connectedDevice;
  int _batteryLevel = 0;
  bool _isConnected = false;

  int get batteryLevel => _batteryLevel;
  bool get isConnected => _isConnected;

  // UUIDs (DEBES OBTENERLOS DE TU FIRMWARE ESP32)
  final String SERVICE_UUID = "TU_SERVICE_UUID";
  final String BATTERY_CHAR_UUID = "TU_BATERIA_CHAR_UUID";
  final String LED_CHAR_UUID = "TU_LED_CHAR_UUID";

  CercascoService() {
    // Inicia el escaneo
    scanForDevice();
  }

  void scanForDevice() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        // Busca tu dispositivo (ej. por nombre)
        if (r.device.platformName == "CercascoHub") {
          FlutterBluePlus.stopScan();
          connectToDevice(r.device);
          break;
        }
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectedDevice = device;
      _isConnected = true;
      discoverServices();
    } catch (e) {
      // ... manejo de error
    }
    notifyListeners();
  }

  Future<void> discoverServices() async {
    if (_connectedDevice == null) return;
    List<BluetoothService> services = await _connectedDevice!.discoverServices();

    for (var service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (var char in service.characteristics) {
          if (char.uuid.toString() == BATTERY_CHAR_UUID) {
            // Suscribirse a la batería
            await char.setNotifyValue(true);
            char.value.listen((value) {
              _batteryLevel = value.isNotEmpty ? value[0] : 0;
              notifyListeners();
            });
          }
        }
      }
    }
  }

  Future<void> setLedColor(Color color) async {
    // ... (Lógica para encontrar el characteristic de LED y escribir el valor)
    // Esto enviará el comando al ESP32
  }
}