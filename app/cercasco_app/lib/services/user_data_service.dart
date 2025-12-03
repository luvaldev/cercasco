import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Datos del Usuario en Memoria ---
  Color _ledColor = Colors.blue; // Color por defecto
  int _ledIntensity = 70; // Intensidad por defecto
  int _totalAlerts = 0; // Estadística de ejemplo

  // --- Getters públicos ---
  Color get ledColor => _ledColor;
  int get ledIntensity => _ledIntensity;
  int get totalAlerts => _totalAlerts;

  // Referencia al documento del usuario
  DocumentReference? get _userDocRef {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _firestore.collection('users').doc(user.uid);
  }

  /// 1. Llamado al registrarse
  /// Crea el documento inicial para un nuevo usuario
  Future<void> createInitialUserData(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);

    // Define los datos por defecto
    final defaultData = {
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
      'config': {
        'ledColor': '#FF2196F3', // Azul por defecto en Hex
        'ledIntensity': 70,
      },
      'stats': {
        'totalAlerts': 0,
        'lastRideKm': 0,
      }
    };

    try {
      await docRef.set(defaultData);
      // Setea los valores locales
      _ledColor = Colors.blue;
      _ledIntensity = 70;
      _totalAlerts = 0;
      notifyListeners();
    } catch (e) {
      print("Error creando documento de usuario: $e");
    }
  }

  /// 2. Llamado al iniciar sesión
  /// Carga los datos del usuario desde Firestore a la app
  Future<void> loadUserData() async {
    if (_userDocRef == null) return;

    try {
      final doc = await _userDocRef!.get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        // Cargar Configuración
        if (data.containsKey('config')) {
          final config = data['config'] as Map<String, dynamic>;
          _ledColor = _hexToColor(config['ledColor'] ?? '#FF2196F3');
          _ledIntensity = config['ledIntensity'] ?? 70;
        }

        // Cargar Estadísticas
        if (data.containsKey('stats')) {
          final stats = data['stats'] as Map<String, dynamic>;
          _totalAlerts = stats['totalAlerts'] ?? 0;
        }

        notifyListeners();
      }
    } catch (e) {
      print("Error cargando datos de usuario: $e");
    }
  }

  /// 3. Llamado desde el Home para guardar cambios
  /// Actualiza la configuración de LEDs en Firestore
  Future<void> updateLedConfig(Color newColor, int newIntensity) async {
    if (_userDocRef == null) return;

    // Actualiza el estado local inmediatamente
    _ledColor = newColor;
    _ledIntensity = newIntensity;
    notifyListeners();

    // Prepara los datos para Firestore
    final configData = {
      'config': {
        'ledColor': _colorToHex(_ledColor),
        'ledIntensity': _ledIntensity,
      }
    };

    try {
      // Usa .set con merge:true para actualizar o crear el campo 'config'
      await _userDocRef!.set(configData, SetOptions(merge: true));
    } catch (e) {
      print("Error actualizando config de LED: $e");
    }
  }

  Future<void> incrementAlerts() async {
    // 1. Actualizamos el valor visualmente rápido
    _totalAlerts++;
    notifyListeners();

    // 2. Guardamos en Firebase (si el usuario está logueado)
    if (_userDocRef != null) {
      try {
        await _userDocRef!.set({
          'stats': {
            'totalAlerts': FieldValue.increment(1) // Suma 1 atómicamente
          }
        }, SetOptions(merge: true));
        print(">>> ✅ Alerta guardada en Firebase");
      } catch (e) {
        print("Error guardando alerta: $e");
      }
    }
  }

  // --- Funciones Helper ---
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Añade alfa si no existe
    }
    return Color(int.parse(hex, radix: 16));
  }
}