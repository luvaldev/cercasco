import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  // Por defecto, iniciamos con el tema oscuro que ya diseñamos
  ThemeMode _themeMode = ThemeMode.dark;

  // Getter para que el resto de la app sepa el estado actual
  ThemeMode get themeMode => _themeMode;

  // Getter para saber si estamos en modo oscuro (útil para la UI)
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // La función que llamará el interruptor para cambiar el tema
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica a todos los 'Consumers' que el tema cambió
  }
}