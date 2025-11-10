// Importa el paquete de autenticación de Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false; // Para mostrar un indicador de carga

  // ---- FUNCIÓN DE LOGIN AÑADIDA ----
  Future<void> _loginUser() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      // Usa Firebase Auth para iniciar sesión
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Si el login es exitoso, navega al Home
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores (ej. usuario no encontrado, contraseña incorrecta)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: ${e.message}')),
        );
      }
    } finally {
      // Oculta el indicador de carga
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  // ------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... (El resto de tu UI: Título, TextFields) ...

            const SizedBox(height: 30),

            // ---- LÓGICA DE BOTÓN ACTUALIZADA ----
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _loginUser, // Llama a la función de login
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.blueAccent),
              child: const Text('Entrar'),
            ),

            // ... (El resto de tu UI: Botón de registro) ...
          ],
        ),
      ),
    );
  }
}