import 'package:flutter/material.dart';
import '../screens/screens.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Usuarios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/admin': (context) => const AdminScreen(),
        '/personas': (context) => const ListaPersonas(),
        '/detalle': (context) {
          final persona =
          ModalRoute.of(context)!.settings.arguments as Persona;

          return DetallePersona(persona: persona);
        },
        '/formulario': (context) {
          final persona =
          ModalRoute.of(context)!.settings.arguments as Persona?;

          return FormularioPersona(persona: persona);
        },
        '/configuracion': (context) {
          final persona = UsuariosMemoria.usuarioActual;

          if (persona == null) {
            return const LoginScreen();
          }

          return Configuracion(persona: persona);
        },
      },
    );
  }
}
