import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../services/cercasco_service.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart'; // 1. Importar
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final cercascoService = Provider.of<CercascoService>(context, listen: false);

    if (!cercascoService.isConnected && !cercascoService.isScanning) {
      Future.microtask(() => cercascoService.scanForDevice());
    }

    return Scaffold(
      extendBodyBehindAppBar: themeService.isDarkMode,
      appBar: AppBar(
        title: Text(
          'Cercasco Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeService.isDarkMode ? Colors.white : null,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeService.isDarkMode ? Colors.transparent : Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          Consumer<ThemeService>(
            builder: (context, theme, child) => Switch(
              value: theme.isDarkMode,
              onChanged: (value) {
                theme.toggleTheme();
              },
              activeTrackColor: Colors.blueAccent.shade100,
              activeColor: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: themeService.isDarkMode ? Colors.white : null,
            ),
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
        width: double.infinity,
        height: double.infinity,
        decoration: themeService.isDarkMode
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade100,
              Colors.deepPurpleAccent.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )
            : BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGlassCard(
                  context: context,
                  child: Consumer<CercascoService>(
                    builder: (context, service, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            context: context,
                            icon: Icons.bluetooth_connected,
                            title: 'Estado del Casco',
                          ),
                          Text(
                            service.isConnected
                                ? 'Conectado a CercascoHub'
                                : (service.isScanning ? 'Buscando CercascoHub...' : 'Desconectado'),
                            style: _getCardTextStyle(context, isSubtitle: true),
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
                              Icon(Icons.battery_full, color: service.isConnected ? (themeService.isDarkMode ? Colors.white : Colors.green) : Colors.grey, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Batería: ${service.isConnected ? '${service.batteryLevel} %' : 'N/A'}',
                                style: _getCardTextStyle(context),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

                _buildGlassCard(
                  context: context,
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            context: context,
                            icon: Icons.color_lens,
                            title: 'Control de LEDs RGB',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Color actual:', style: _getCardTextStyle(context)),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: userData.ledColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: themeService.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.grey.shade300),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Intensidad:', style: _getCardTextStyle(context)),
                              Text('${userData.ledIntensity} %', style: _getCardTextStyle(context)),
                            ],
                          ),
                          Slider(
                            value: userData.ledIntensity.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: themeService.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                            inactiveColor: themeService.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.shade300,
                            onChanged: (double value) {
                              userData.updateLedConfig(userData.ledColor, value.toInt());
                            },
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _showColorPicker(context, userData.ledColor, (newColor) {
                                  userData.updateLedConfig(newColor, userData.ledIntensity);
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

                // --- Tarjeta de Estadísticas ---
                _buildGlassCard(
                  context: context,
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardTitle(
                            context: context,
                            icon: Icons.analytics,
                            title: 'Estadísticas de Uso',
                          ),
                          _buildStatRow(
                            context: context,
                            icon: Icons.shield_outlined,
                            label: 'Total de Alertas:',
                            value: '${userData.totalAlerts}',
                          ),
                          _buildStatRow(
                            context: context,
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


  Widget _buildGlassCard({required BuildContext context, required Widget child}) {
    final cardTheme = Theme.of(context).cardTheme;
    return Card(
      elevation: cardTheme.elevation,
      shadowColor: cardTheme.shadowColor,
      color: cardTheme.color,
      shape: cardTheme.shape,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildCardTitle({required BuildContext context, required IconData icon, required String title}) {
    final bool isDark = Provider.of<ThemeService>(context, listen: false).isDarkMode;
    final Color iconColor = isDark ? Colors.white : Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _glassButtonStyle(BuildContext context) {
    return Theme.of(context).elevatedButtonTheme.style!.copyWith(
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25, vertical: 12)),
    );
  }

  TextStyle _getCardTextStyle(BuildContext context, {bool isSubtitle = false}) {
    final bool isDark = Provider.of<ThemeService>(context, listen: false).isDarkMode;
    if (isDark) {
      return TextStyle(
        fontSize: isSubtitle ? 16 : 15,
        color: isSubtitle ? Colors.white.withOpacity(0.8) : Colors.white,
      );
    } else {
      return TextStyle(
        fontSize: isSubtitle ? 16 : 15,
        color: isSubtitle ? Colors.black54 : Colors.black87,
      );
    }
  }

  Widget _buildStatRow({required BuildContext context, required IconData icon, required String label, required String value}) {
    final bool isDark = Provider.of<ThemeService>(context, listen: false).isDarkMode;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white.withOpacity(0.8) : Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: subTextColor, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: subTextColor),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

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