import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Importar
import 'screens/splash_screen.dart';
import 'services/cercasco_service.dart'; // Importar

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Envolver la App en el Provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => CercascoService(),
      child: const CercascoApp(),
    ),
  );
}
// ... (El resto de CercascoApp)