import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'services/cercasco_service.dart';
import 'services/user_data_service.dart';
import 'services/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CercascoService()),
        ChangeNotifierProvider(create: (context) => UserDataService()),
        ChangeNotifierProvider(create: (context) => ThemeService()),
      ],
      child: const CercascoApp(),
    ),
  );
}

class CercascoApp extends StatelessWidget {
  const CercascoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- PALETA DE COLORES ---
    // Modo Oscuro (Cyberpunk/Neon)
    final Color darkBg = const Color(0xFF0D0D25);
    final Color darkCard = const Color(0xFF1F1B40);
    final Color neonPink = const Color(0xFFD040C0);
    final Color neonCyan = const Color(0xFF40C4FF);

    // Modo Claro
    final Color lightPrimary = const Color(0xFF4A148C);

    // --- TEMA CLARO ---
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: Colors.grey[50],
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimary,
        brightness: Brightness.light,
        primary: lightPrimary,
        secondary: neonPink,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: lightPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // SIN textStyle AQUÍ PARA EVITAR ERRORES
        ),
      ),
      useMaterial3: true,
    );

    // --- TEMA OSCURO ---
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: neonPink,
      scaffoldBackgroundColor: darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: neonPink,
        brightness: Brightness.dark,
        primary: neonPink,
        secondary: neonCyan,
        surface: darkCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkCard.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonPink,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: neonPink.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // SIN textStyle AQUÍ PARA EVITAR ERRORES
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.white.withOpacity(0.2),
        thumbColor: neonCyan,
        trackHeight: 4.0,
      ),
      useMaterial3: true,
    );

    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cercasco',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeService.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}