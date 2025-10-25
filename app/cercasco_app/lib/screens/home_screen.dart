import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cercasco Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.battery_full, color: Colors.green, size: 32),
              title: Text('Nivel de batería'),
              subtitle: Text('85 %'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light_mode, color: Colors.amber, size: 32),
              title: Text('Control de LEDs'),
              subtitle: Text('Color: Azul, Intensidad: 70 %'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.bluetooth_connected, color: Colors.blue, size: 32),
              title: Text('Conexión casco'),
              subtitle: Text('Activo'),
            ),
          ],
        ),
      ),
    );
  }
}
