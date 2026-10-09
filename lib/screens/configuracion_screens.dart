import 'package:flutter/material.dart';
import '../screens/screens.dart';
class Configuracion extends StatefulWidget {
  final Persona persona;

  const Configuracion({
    super.key,
    required this.persona,
  });

  @override
  State<Configuracion> createState() =>
      _ConfiguracionState();
}

class _ConfiguracionState
    extends State<Configuracion> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nombreController;
  late final TextEditingController edadController;
  late final TextEditingController correoController;
  late final TextEditingController telefonoController;


  @override
  void initState() {
    super.initState();

    final persona = widget.persona;

    nombreController = TextEditingController(text: persona.Nombre);
    edadController =
        TextEditingController(text: persona.Edad.toString());
    correoController = TextEditingController(text: persona.correo);
    telefonoController =
        TextEditingController(text: persona.telefono);
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  void guardarCambios() {
    if (!_formKey.currentState!.validate()) return;

    final edad = int.tryParse(edadController.text.trim());

    if (edad == null || edad < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa una edad válida.')),
      );
      return;
    }

    final persona = widget.persona;

    persona.Nombre = nombreController.text.trim();
    persona.Edad = edad;
    persona.correo = correoController.text.trim();
    persona.telefono = telefonoController.text.trim();
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tus datos se guardaron correctamente.'),
      ),
    );
  }

  void cerrarSesion() {
    UsuariosMemoria.cerrarSesion();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
          (route) => false,
    );
  }

  String? validar(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final usuarioActual = UsuariosMemoria.usuarioActual;

    if (usuarioActual == null ||
        !identical(usuarioActual, widget.persona)) {
      return const Scaffold(
        body: Center(
          child: Text('No tienes permiso para ver estos datos.'),
        ),
      );
    }

    return PopScope(
      canPop: usuarioActual.rol == 'Administrador',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi configuración'),
          automaticallyImplyLeading:
          usuarioActual.rol == 'Administrador',
          actions: [
            IconButton(
              onPressed: cerrarSesion,
              tooltip: 'Cerrar sesión',
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.indigo,
              ),
              Center(
                child: Text(
                  'Rol: ${usuarioActual.rol}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _campo('Nombre', nombreController),
              _campo(
                'Edad',
                edadController,
                tipo: TextInputType.number,
              ),
              _campo(
                'Correo',
                correoController,
                tipo: TextInputType.emailAddress,
              ),
              _campo(
                'Teléfono',
                telefonoController,
                tipo: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: cerrarSesion,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo(
      String etiqueta,
      TextEditingController controller, {
        TextInputType tipo = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        validator: validar,
        decoration: InputDecoration(
          labelText: etiqueta,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}