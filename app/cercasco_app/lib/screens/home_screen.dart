import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importar
import '../services/cercasco_service.dart'; // Importar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios del servicio
    final cercascoService = Provider.of<CercascoService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cercasco Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.battery_full, color: Colors.green, size: 32),
              title: Text('Nivel de batería'),
              // ---- DATO REAL ----
              subtitle: Text('${cercascoService.batteryLevel} %'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light_mode, color: Colors.amber, size: 32),
              title: Text('Control de LEDs'),
              // TODO: Añadir botones o un slider para llamar a
              // cercascoService.setLedColor(Colors.red)
              subtitle: Text('Color: Azul, Intensidad: 70 %'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.bluetooth_connected, color: Colors.blue, size: 32),
              title: Text('Conexión casco'),
              // ---- DATO REAL ----
              subtitle: Text(cercascoService.isConnected ? 'Activo' : 'Desconectado'),
            ),
            // TODO: Añadir la sección de Estadísticas e Historial de Alertas
          ],
        ),
      ),
    );
  }
}