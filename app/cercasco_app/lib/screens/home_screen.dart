import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../services/cercasco_service.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // --- CORRECCIÓN: Escaneo inicial en initState ---
  @override
  void initState() {
    super.initState();
    // Ejecuta el escaneo después de que se construya la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cercascoService = Provider.of<CercascoService>(context, listen: false);
      if (!cercascoService.isConnected && !cercascoService.isScanning) {
        cercascoService.scanForDevice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    // NOTA: Ya no llamamos a scanForDevice() aquí directamente.

    final bool isDark = themeService.isDarkMode;
    final Color reconnectBtnColor = isDark ? const Color(0xFF103060) : Colors.blueAccent;
    final Color cyanAccent = const Color(0xFF40C4FF);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Cercasco Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Transform.scale(
            scale: 0.8,
            child: Consumer<ThemeService>(
              builder: (context, theme, child) => Switch(
                value: theme.isDarkMode,
                onChanged: (value) => theme.toggleTheme(),
                activeColor: Colors.white,
                activeTrackColor: Colors.white.withOpacity(0.2),
                inactiveThumbColor: Colors.grey,
              ),
            ),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: isDark ? Colors.white : Colors.black87,
                size: 20,
              ),
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
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: isDark
            ? const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A0A1E),
              Color(0xFF181035),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : BoxDecoration(
          color: Colors.grey[100],
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // --- Tarjeta 1: Estado del Casco ---
                _buildStyledCard(
                  context: context,
                  child: Consumer<CercascoService>(
                    builder: (context, service, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardHeader(
                            context: context,
                            icon: Icons.flash_on_rounded,
                            title: 'Estado del Casco',
                            iconColor: cyanAccent,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            service.isConnected
                                ? 'Conectado'
                                : (service.isScanning ? 'Buscando...' : 'Desconectado'),
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (!service.isConnected)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: service.isScanning ? null : () => service.scanForDevice(),
                                icon: const Icon(Icons.refresh_rounded),
                                label: Text(
                                  service.isScanning ? 'Buscando...' : 'Reconnectar Casco',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: reconnectBtnColor,
                                  foregroundColor: isDark ? cyanAccent : Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.bolt, color: isDark ? Colors.grey : Colors.black54, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                'Batería: ${service.isConnected ? '${service.batteryLevel} %' : 'N/A'}',
                                style: TextStyle(fontSize: 14, color: isDark ? Colors.grey : Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // --- Tarjeta 2: Control de LEDs ---
                _buildStyledCard(
                  context: context,
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardHeader(
                            context: context,
                            icon: Icons.lightbulb_outline_rounded,
                            title: 'Control de LEDs RGB',
                            iconColor: Colors.amber,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Color actual:',
                                style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: userData.ledColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: userData.ledColor.withOpacity(0.6),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Intensidad:', style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black54)),
                              Text('${userData.ledIntensity} %', style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 6,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                            ),
                            child: Slider(
                              value: userData.ledIntensity.toDouble(),
                              min: 0,
                              max: 100,
                              activeColor: isDark ? Colors.white : Theme.of(context).primaryColor,
                              thumbColor: cyanAccent,
                              inactiveColor: isDark ? Colors.white24 : Colors.grey.shade300,
                              onChanged: (double value) {
                                userData.updateLedConfig(userData.ledColor, value.toInt());
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: isDark ? const LinearGradient(
                                  colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                                ) : null,
                                color: isDark ? null : Theme.of(context).primaryColor,
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _showColorPicker(context, userData.ledColor, (newColor) {
                                    userData.updateLedConfig(newColor, userData.ledIntensity);
                                  });
                                },
                                icon: const Icon(Icons.color_lens_outlined, color: Colors.white),
                                label: const Text('Cambiar Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // --- Tarjeta 3: Estadísticas ---
                _buildStyledCard(
                  context: context,
                  child: Consumer<UserDataService>(
                    builder: (context, userData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCardHeader(
                            context: context,
                            icon: Icons.bar_chart_rounded,
                            title: 'Estadísticas de Uso',
                            iconColor: Colors.greenAccent,
                          ),
                          const SizedBox(height: 20),
                          _buildStatRow(
                            context: context,
                            icon: Icons.radar_rounded,
                            label: 'Total de Alertas:',
                            value: '${userData.totalAlerts}',
                          ),
                          Divider(color: isDark ? Colors.white10 : Colors.grey.shade200, height: 20),
                          _buildStatRow(
                            context: context,
                            icon: Icons.directions_bike_rounded,
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

  Widget _buildStyledCard({required BuildContext context, required Widget child}) {
    final cardTheme = Theme.of(context).cardTheme;
    final isDark = Provider.of<ThemeService>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: cardTheme.color,
        borderRadius: (cardTheme.shape as RoundedRectangleBorder).borderRadius,
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.transparent,
          width: 1,
        ),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }

  Widget _buildCardHeader({required BuildContext context, required IconData icon, required String title, required Color iconColor}) {
    final isDark = Provider.of<ThemeService>(context).isDarkMode;
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow({required BuildContext context, required IconData icon, required String label, required String value}) {
    final isDark = Provider.of<ThemeService>(context).isDarkMode;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white54 : Colors.black54;

    return Row(
      children: [
        Icon(icon, color: subTextColor, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: subTextColor),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    final isDark = Provider.of<ThemeService>(context, listen: false).isDarkMode;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1F1B40) : Colors.white,
          title: Text('Selecciona un Color', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
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