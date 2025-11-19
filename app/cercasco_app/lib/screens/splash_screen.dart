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
    final themeService = Provider.of<ThemeService>(context);
    final bool isDark = themeService.isDarkMode;

    // Colores Neón
    final Color neonPink = const Color(0xFFD040C0);
    final Color neonCyan = const Color(0xFF40C4FF);

    return Scaffold(
      body: Container(
        decoration: isDark
            ? const BoxDecoration(
          // El mismo degradado profundo del Home
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A0A1E), // Casi negro arriba
              Color(0xFF181035), // Morado oscuro abajo
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono con efecto de "Resplandor" (Shadow) en modo oscuro
              Container(
                decoration: isDark ? BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: neonCyan.withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ) : null,
                child: Icon(
                  Icons.sports_motorsports,
                  size: 120,
                  // En oscuro usamos Cian para el icono, en claro el primario
                  color: isDark ? neonCyan : Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Cercasco',
                style: TextStyle(
                  fontSize: 40,
                  // Fuente blanca en oscuro, negra en claro
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w900, // Fuente más gruesa y moderna
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '“Más seguridad, más confianza.”',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 60),
              CircularProgressIndicator(
                // Loader Rosa Neón en oscuro
                color: isDark ? neonPink : Theme.of(context).primaryColor,
                strokeWidth: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}