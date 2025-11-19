import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_data_service.dart';
import '../services/theme_service.dart';

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
            content: Text('¡Cuenta creada! Inicia sesión.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
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

    // Colores
    final Color neonPink = const Color(0xFFD040C0);
    final Color neonCyan = const Color(0xFF40C4FF);
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color hintColor = isDark ? Colors.white54 : Colors.black45;
    final Color inputFill = isDark ? const Color(0xFF1F1B40).withOpacity(0.6) : Colors.white;
    final Color inputBorder = isDark ? Colors.white10 : Colors.grey.shade300;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: isDark ? neonCyan : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Únete a la comunidad Cercasco',
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

                // --- Botón Registrar (Neon Pink) ---
                _isLoading
                    ? CircularProgressIndicator(color: isDark ? neonPink : Theme.of(context).primaryColor)
                    : SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _registerUser,
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
                      'REGISTRAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
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
            color: isDark ? const Color(0xFF40C4FF) : Colors.deepPurple,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}