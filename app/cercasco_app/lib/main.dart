import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'services/cercasco_service.dart';
import 'services/user_data_service.dart'; // 1. Importar el nuevo servicio

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 2. Usar MultiProvider para manejar ambos servicios
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CercascoService()),
        ChangeNotifierProvider(create: (context) => UserDataService()),
      ],
      child: const CercascoApp(),
    ),
  );
}

class CercascoApp extends StatelessWidget {
  const CercascoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cercasco',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}