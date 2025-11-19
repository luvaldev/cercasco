import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart';

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
            content: Text('Error: ${e.message}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
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
    final themeService = Provider.of<ThemeService>(context);
    final bool isDark = themeService.isDarkMode;

    // Colores del diseño nuevo
    final Color neonPink = const Color(0xFFD040C0);
    final Color neonCyan = const Color(0xFF40C4FF);

    // Estilos dinámicos
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color hintColor = isDark ? Colors.white54 : Colors.black45;
    // Fondo de inputs: Morado oscuro semitransparente en modo oscuro
    final Color inputFill = isDark ? const Color(0xFF1F1B40).withOpacity(0.6) : Colors.white;
    final Color inputBorder = isDark ? Colors.white10 : Colors.grey.shade300;

    return Scaffold(
      body: Container(
        decoration: isDark
            ? const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A0A1E),
              Color(0xFF181035),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_motorsports_outlined,
                  size: 80,
                  color: isDark ? neonCyan : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(fontSize: 16, color: hintColor),
                ),
                const SizedBox(height: 40),

                // --- Input Email ---
                _buildCyberInput(
                  controller: emailController,
                  label: 'Correo electrónico',
                  icon: Icons.email_outlined,
                  isDark: isDark,
                  fillColor: inputFill,
                  borderColor: inputBorder,
                  textColor: textColor,
                  hintColor: hintColor,
                ),
                const SizedBox(height: 20),

                // --- Input Password ---
                _buildCyberInput(
                  controller: passwordController,
                  label: 'Contraseña',
                  icon: Icons.lock_outline_rounded,
                  isObscure: true,
                  isDark: isDark,
                  fillColor: inputFill,
                  borderColor: inputBorder,
                  textColor: textColor,
                  hintColor: hintColor,
                ),
                const SizedBox(height: 40),

                // --- Botón Entrar (Neon Pink) ---
                _isLoading
                    ? CircularProgressIndicator(color: isDark ? neonPink : Theme.of(context).primaryColor)
                    : SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? neonPink : Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      elevation: isDark ? 10 : 2,
                      shadowColor: isDark ? neonPink.withOpacity(0.4) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Link Registro ---
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '¿No tienes cuenta? ',
                      style: TextStyle(color: hintColor),
                      children: [
                        TextSpan(
                          text: 'Regístrate',
                          style: TextStyle(
                            color: isDark ? neonCyan : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para inputs con estilo consistente
  Widget _buildCyberInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    required bool isDark,
    required Color fillColor,
    required Color borderColor,
    required Color textColor,
    required Color hintColor,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: hintColor),
        prefixIcon: Icon(icon, color: hintColor),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF40C4FF) : Colors.deepPurple, // Cian al enfocar en oscuro
            width: 1.5,
          ),
        ),
      ),
    );
  }
}