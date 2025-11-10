import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Consumir el servicio de tema
    final themeService = Provider.of<ThemeService>(context);

    // Definir colores basados en el tema
    final Color iconColor = themeService.isDarkMode ? Colors.white : Colors.deepPurpleAccent;
    final Color textColor = themeService.isDarkMode ? Colors.white : Colors.black87;
    final Color sloganColor = themeService.isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      body: Container(
        // --- DECORACIÓN CONDICIONAL ---
        decoration: themeService.isDarkMode
            ? BoxDecoration(
          // Fondo Degradado (Modo Oscuro)
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
          // Fondo Sólido (Modo Claro)
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        // -------------------------
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sports_motorsports,
                size: 140,
                color: iconColor, // Color dinámico
              ),
              const SizedBox(height: 20),
              Text(
                'Cercasco',
                style: TextStyle(
                  fontSize: 32,
                  color: textColor, // Color dinámico
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '“Más seguridad, más confianza, más ciclismo.”',
                style: TextStyle(
                  fontSize: 14,
                  color: sloganColor, // Color dinámico
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 40),
              CircularProgressIndicator(
                color: iconColor, // Color dinámico
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}