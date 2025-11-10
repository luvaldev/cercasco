import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart'; // 1. Importar

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final userDataService = Provider.of<UserDataService>(context, listen: false);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (credential.user != null) {
        await userDataService.createInitialUserData(credential.user!);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro exitoso. Ahora inicia sesión.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al registrar: ${e.message}'),
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
    final Color textColor = themeService.isDarkMode ? Colors.white : Colors.black87;
    final Color textLabelColor = themeService.isDarkMode ? Colors.white70 : Colors.black54;
    final Color fieldBgColor = themeService.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white;
    final Color buttonBgColor = themeService.isDarkMode ? Colors.white : Colors.deepPurpleAccent;
    final Color buttonFgColor = themeService.isDarkMode ? Colors.deepPurpleAccent : Colors.white;
    final Color iconColor = themeService.isDarkMode ? Colors.white : Colors.black87;


    return Scaffold(
      body: Container(
        // 4. Decoración condicional
        width: double.infinity,
        height: double.infinity,
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
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crear Cuenta',
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

                    // --- Botón de Registrar ---
                    _isLoading
                        ? CircularProgressIndicator(color: iconColor)
                        : ElevatedButton(
                      onPressed: _registerUser,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: buttonBgColor, // Dinámico
                        foregroundColor: buttonFgColor, // Dinámico
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Registrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),

            // --- Botón de "Atrás" ---
            Positioned(
              top: 40,
              left: 10,
              child: SafeArea( // Añadido SafeArea por si acaso
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: iconColor), // Dinámico
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}