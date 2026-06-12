import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _loading = false;

  Future<void> _login() async {
    try {
      setState(() {
        _loading = true;
      });

      await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      String mensaje = "Error al iniciar sesión";

      if (e.toString().contains("user-not-found")) {
        mensaje = "No existe una cuenta con ese correo";
      } else if (e.toString().contains("wrong-password")) {
        mensaje = "La contraseña es incorrecta";
      } else if (e.toString().contains("invalid-email")) {
        mensaje = "El correo no es válido";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _register() async {
    try {
      setState(() {
        _loading = true;
      });

      await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
    } catch (e) {
      String mensaje = "No se pudo crear la cuenta";

      if (e.toString().contains("email-already-in-use")) {
        mensaje = "Ya existe una cuenta con ese correo";
      } else if (e.toString().contains("weak-password")) {
        mensaje = "La contraseña debe tener al menos 6 caracteres";
      } else if (e.toString().contains("invalid-email")) {
        mensaje = "El correo ingresado no es válido";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: const Text('Iniciar sesión'),
            ),

            ElevatedButton(
              onPressed: _loading ? null : _register,
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
