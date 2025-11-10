import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../services/cercasco_service.dart';
import '../services/user_data_service.dart';
import 'login_screen.dart'; // Para navegar de vuelta al login

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha el servicio BLE (sin reconstruir la UI) para iniciar escaneo
    final cercascoService = Provider.of<CercascoService>(context, listen: false);

    // Inicia un escaneo BLE si no está conectado
    if (!cercascoService.isConnected && !cercascoService.isScanning) {
      Future.microtask(() => cercascoService.scanForDevice());
    }

    return Scaffold(
      // --- CAMBIO: AppBar transparente y extendido ---
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Cercasco Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Transparente
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // Icono blanco
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        // --- CAMBIO: Fondo degradado ---
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade100,
              Colors.deepPurpleAccent.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea( // SafeArea para evitar que el contenido se vaya al notch
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Tarjeta de Conexión del Casco (Estilo "Glass") ---
                _buildGlassCard(
                  child: Consumer<CercascoService>(
                    builder: (context, service, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            icon: Icons.bluetooth_connected,
                            title: 'Estado del Casco',
                          ),
                          Text(
                            service.isConnected
                                ? 'Conectado a CercascoHub'
                                : (service.isScanning ? 'Buscando CercascoHub...' : 'Desconectado'),
                            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                          ),
                          if (!service.isConnected) ...[
                            const SizedBox(height: 15),
                            ElevatedButton.icon(
                              onPressed: service.isScanning ? null : () => service.scanForDevice(),
                              icon: const Icon(Icons.refresh),
                              label: Text(service.isScanning ? 'Buscando...' : 'Reconectar Casco'),
                              style: _glassButtonStyle(context),
                            ),
                          ],
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.battery_full, color: service.isConnected ? Colors.white : Colors.white.withOpacity(0.5), size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Batería: ${service.isConnected ? '${service.batteryLevel} %' : 'N/A'}',
                                style: const TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // --- Tarjeta de Control de LEDs (Estilo "Glass") ---
                _buildGlassCard(
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            icon: Icons.color_lens,
                            title: 'Control de LEDs RGB',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Color actual:', style: TextStyle(fontSize: 16, color: Colors.white)),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: userData.ledColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Intensidad:', style: TextStyle(fontSize: 16, color: Colors.white)),
                              Text('${userData.ledIntensity} %', style: const TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                          Slider(
                            value: userData.ledIntensity.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white.withOpacity(0.3),
                            onChanged: (double value) {
                              userData.updateLedConfig(userData.ledColor, value.toInt());
                              // TODO: Enviar el comando BLE de intensidad a cercascoService
                              // cercascoService.setLedIntensity(value.toInt());
                            },
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _showColorPicker(context, userData.ledColor, (newColor) {
                                  userData.updateLedConfig(newColor, userData.ledIntensity);
                                  // TODO: Enviar el comando BLE de color a cercascoService
                                  // cercascoService.setLedColor(newColor);
                                });
                              },
                              icon: const Icon(Icons.palette),
                              label: const Text('Cambiar Color'),
                              style: _glassButtonStyle(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // --- Tarjeta de Estadísticas (Estilo "Glass") ---
                _buildGlassCard(
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            icon: Icons.analytics,
                            title: 'Estadísticas de Uso',
                          ),
                          _buildStatRow(
                            icon: Icons.shield_outlined,
                            label: 'Total de Alertas:',
                            value: '${userData.totalAlerts}',
                          ),
                          _buildStatRow(
                            icon: Icons.map_outlined,
                            label: 'Último Viaje (km):',
                            value: '0', // Placeholder
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS DE ESTILO REUTILIZABLES ---

  // Estilo para las tarjetas "Glassmorphism"
  Widget _buildGlassCard({required Widget child}) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      color: Colors.white.withOpacity(0.15), // Color semitransparente
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.2)), // Borde sutil
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  // Estilo para los títulos de las tarjetas
  Widget _buildCardTitle({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Estilo para los botones principales
  ButtonStyle _glassButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white.withOpacity(0.9),
      foregroundColor: Colors.deepPurpleAccent.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  // Estilo para las filas de estadísticas
  Widget _buildStatRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Función para mostrar el selector de color (sin cambios)
  void _showColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              paletteType: PaletteType.hsvWithSaturation,
              enableAlpha: false,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Listo'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}