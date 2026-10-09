import 'package:flutter/material.dart';
import '../screens/screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuarioController = TextEditingController();
  final claveController = TextEditingController();

  String? error;

  void ingresar() {
    final usuario = usuarioController.text.trim();
    final clave = claveController.text;

    final persona = UsuariosMemoria.iniciarSesion(usuario, clave);

    if (persona == null) {
      setState(() {
        error = 'Usuario o contraseña incorrectos.';
      });
      return;
    }

    if (persona.rol == 'Administrador') {
      Navigator.pushReplacementNamed(context, '/admin');
    } else if (persona.rol == 'Persona') {
      Navigator.pushReplacementNamed(context, '/configuracion');
    }
  }

  @override
  void dispose() {
    usuarioController.dispose();
    claveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 90,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gestión de Usuarios',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: claveController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => ingresar(),
                ),
                if (error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ingresar,
                    child: const Text('Ingresar'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Administrador: admin / admin123',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Persona: juan / juan123',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}