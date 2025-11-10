import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cercasco_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cercascoService = Provider.of<CercascoService>(context);

    if (!cercascoService.isConnected && !cercascoService.isScanning) {
      cercascoService.scanForDevice();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cercasco Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.battery_full, color: Colors.green, size: 32),
              title: Text('Nivel de batería'),
              subtitle: Text(
                  cercascoService.isConnected
                      ? '${cercascoService.batteryLevel} %'
                      : 'Desconectado'
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light_mode, color: Colors.amber, size: 32),
              title: Text('Control de LEDs'),
              subtitle: Text('Color: Azul, Intensidad: 70 % (Demo)'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.bluetooth_connected, color: Colors.blue, size: 32),
              title: Text('Conexión casco'),
              subtitle: Text(
                  cercascoService.isConnected
                      ? 'Activo'
                      : (cercascoService.isScanning ? 'Buscando...' : 'Desconectado')
              ),
              trailing: cercascoService.isConnected
                  ? null
                  : IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  cercascoService.scanForDevice();
                },
              ),
            ),
            // TODO: Añadir la sección de Estadísticas e Historial de Alertas
          ],
        ),
      ),
    );
  }
}