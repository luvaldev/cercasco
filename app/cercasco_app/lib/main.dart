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
    // Definimos los colores base
    final Color primaryColor = Colors.deepPurpleAccent.shade200;
    final Color accentColor = Colors.blueAccent.shade100;

    // --- TEMA CLARO ---
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.grey[100],
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // --- LÍNEA 'textStyle' ELIMINADA DE AQUÍ ---
        ),
      ),
      useMaterial3: true,
    );

    // --- TEMA OSCURO ---
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black, // El degradado lo sobreescribirá
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        secondary: accentColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        color: Colors.white.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: Colors.deepPurpleAccent.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // --- LÍNEA 'textStyle' ELIMINADA DE AQUÍ ---
        ),
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