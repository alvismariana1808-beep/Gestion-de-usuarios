import 'package:flutter/material.dart';
import '../screens/screens.dart ';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  void cerrarSesion(BuildContext context) {
    UsuariosMemoria.cerrarSesion();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final administrador = UsuariosMemoria.usuarioActual;

    if (administrador == null ||
        administrador.rol != 'Administrador') {
      return Scaffold(
        appBar: AppBar(title: const Text('Acceso restringido')),
        body: const Center(
          child: Text('No tienes permiso para acceder.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Administrador'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => cerrarSesion(context),
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenido, ${administrador.Nombre}',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('¿Qué deseas hacer?'),
            const SizedBox(height: 25),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Gestionar personas'),
                subtitle: const Text(
                  'Ver, registrar y editar usuarios',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, '/personas');
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Mi configuración'),
                subtitle: const Text('Editar mis datos personales'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    '/configuracion',
                  );
                },
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () => cerrarSesion(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}