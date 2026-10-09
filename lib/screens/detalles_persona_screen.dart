import 'package:flutter/material.dart';
import '../screens/screens.dart';


class DetallePersona extends StatefulWidget {
  final Persona persona;

  const DetallePersona({
    super.key,
    required this.persona,
  });

  @override
  State<DetallePersona> createState() =>
      _DetallePersonaScreenState();
}

class _DetallePersonaScreenState
    extends State<DetallePersona> {
  Future<void> editarPersona() async {
    final resultado = await Navigator.pushNamed(
      context,
      '/formulario',
      arguments: widget.persona,
    );

    if (!mounted) return;

    if (resultado == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final persona = widget.persona;

    if (UsuariosMemoria.usuarioActual?.rol != 'Administrador') {
      return const Scaffold(
        body: Center(
          child: Text('No tienes permiso para ver este detalle.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la persona'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.account_circle,
            size: 90,
            color: Colors.indigo,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              persona.Nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _dato('Nombre', persona.Nombre),
          _dato('Edad', '${persona.Edad} años'),
          _dato('Correo', persona.correo),
          _dato('Teléfono', persona.telefono),
          _dato('Usuario', persona.Usuario),
          _dato('Rol', persona.rol),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: editarPersona,
            icon: const Icon(Icons.edit),
            label: const Text('Editar persona'),
          ),
        ],
      ),
    );
  }

  Widget _dato(String titulo, String valor) {
    return Card(
      child: ListTile(
        title: Text(titulo),
        subtitle: Text(valor),
      ),
    );
  }
}