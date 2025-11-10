import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart'; // 1. Importar

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final userDataService = Provider.of<UserDataService>(context, listen: false);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await userDataService.loadUserData();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar sesión: ${e.message}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2. Consumir el servicio de tema
    final themeService = Provider.of<ThemeService>(context);

    // 3. Definir colores dinámicos
    final Color iconColor = themeService.isDarkMode ? Colors.white : Colors.deepPurpleAccent;
    final Color textColor = themeService.isDarkMode ? Colors.white : Colors.black87;
    final Color textLabelColor = themeService.isDarkMode ? Colors.white70 : Colors.black54;
    final Color fieldBgColor = themeService.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white;
    final Color buttonBgColor = themeService.isDarkMode ? Colors.white : Colors.deepPurpleAccent;
    final Color buttonFgColor = themeService.isDarkMode ? Colors.deepPurpleAccent : Colors.white;

    return Scaffold(
      body: Container(
        // 4. Decoración condicional
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_motorsports,
                  size: 100,
                  color: iconColor, // Dinámico
                ),
                const SizedBox(height: 20),
                Text(
                  'Bienvenido a Cercasco',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: textColor), // Dinámico
                ),
                const SizedBox(height: 40),

                // --- TextField de Email ---
                TextField(
                  controller: emailController,
                  style: TextStyle(color: textColor), // Dinámico
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: textLabelColor), // Dinámico
                    filled: true,
                    fillColor: fieldBgColor, // Dinámico
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email_outlined, color: textLabelColor), // Dinámico
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // --- TextField de Contraseña ---
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: textColor), // Dinámico
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: textLabelColor), // Dinámico
                    filled: true,
                    fillColor: fieldBgColor, // Dinámico
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock_outline, color: textLabelColor), // Dinámico
                  ),
                ),
                const SizedBox(height: 40),

                // --- Botón de Entrar ---
                _isLoading
                    ? CircularProgressIndicator(color: iconColor)
                    : ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: buttonBgColor, // Dinámico
                    foregroundColor: buttonFgColor, // Dinámico
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Entrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                // --- Botón de Registro ---
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w500), // Dinámico
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}