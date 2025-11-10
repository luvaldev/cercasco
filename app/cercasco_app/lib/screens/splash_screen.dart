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

    final Color iconColor = themeService.isDarkMode ? Colors.white : Colors.deepPurpleAccent;
    final Color textColor = themeService.isDarkMode ? Colors.white : Colors.black87;
    final Color sloganColor = themeService.isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      body: Container(
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
        // -------------------------
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sports_motorsports,
                size: 140,
                color: iconColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Cercasco',
                style: TextStyle(
                  fontSize: 32,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '“Más seguridad, más confianza, más ciclismo.”',
                style: TextStyle(
                  fontSize: 14,
                  color: sloganColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 40),
              CircularProgressIndicator(
                color: iconColor,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}