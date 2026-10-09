import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../models/persona.dart';

class FormularioPersona extends StatefulWidget {
  final Persona? persona;

  const FormularioPersona({
    super.key,
    this.persona,
  });

  @override
  State<FormularioPersona> createState() =>
      _FormularioPersonaScreenState();
}

class _FormularioPersonaScreenState
    extends State<FormularioPersona> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final edadController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final usuarioController = TextEditingController();
  final claveController = TextEditingController();

  bool get esEdicion => widget.persona != null;

  @override
  void initState() {
    super.initState();

    final persona = widget.persona;

    if (persona != null) {
      nombreController.text = persona.Nombre;
      edadController.text = persona.Edad.toString();
      correoController.text = persona.correo;
      telefonoController.text = persona.telefono;
      usuarioController.text = persona.Usuario;
      claveController.text = persona.Clave;
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    usuarioController.dispose();
    claveController.dispose();
    super.dispose();
  }

  String? validarTexto(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }

  void guardar() {
    if (!_formKey.currentState!.validate()) return;

    final nombre = nombreController.text.trim();
    final edad = int.tryParse(edadController.text.trim());
    final correo = correoController.text.trim();
    final telefono = telefonoController.text.trim();
    final usuario = usuarioController.text.trim();
    final clave = claveController.text;

    if (edad == null || edad < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa una edad válida.'),
        ),
      );
      return;
    }

    final duplicado = UsuariosMemoria.personas.any(
          (p) =>
      p.Usuario.toLowerCase() == usuario.toLowerCase() &&
          !identicaPersona(p, widget.persona),
    );

    if (duplicado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ese nombre de usuario ya existe.'),
        ),
      );
      return;
    }

    if (esEdicion) {
      final persona = widget.persona!;

      persona.Nombre = nombre;
      persona.Edad = edad;
      persona.correo = correo;
      persona.telefono = telefono;
      persona.Usuario = usuario;
      persona.Clave = clave;
    } else {
      UsuariosMemoria.agregarPersona(
        Persona(
          Nombre: nombre,
          Edad: edad,
          correo: correo,
          telefono: telefono,
          Usuario: usuario,
          Clave: clave,
          rol: 'Persona',
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          esEdicion
              ? 'Persona actualizada correctamente.'
              : 'Persona registrada correctamente.',
        ),
      ),
    );

    Navigator.pop(context, true);
  }

  bool identicaPersona(Persona a, Persona? b) {
    return identical(a, b);
  }

  @override
  Widget build(BuildContext context) {
    if (UsuariosMemoria.usuarioActual?.rol != 'Administrador') {
      return const Scaffold(
        body: Center(
          child: Text('No tienes permiso para realizar esta acción.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion ? 'Editar persona' : 'Registrar persona',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _campo(
              'Nombre completo',
              nombreController,
              icono: Icons.person,
            ),
            _campo(
              'Edad',
              edadController,
              icono: Icons.cake,
              tipo: TextInputType.number,
            ),
            _campo(
              'Correo electrónico',
              correoController,
              icono: Icons.email,
              tipo: TextInputType.emailAddress,
            ),
            _campo(
              'Teléfono',
              telefonoController,
              icono: Icons.phone,
              tipo: TextInputType.phone,
            ),
            _campo(
              'Nombre de usuario',
              usuarioController,
              icono: Icons.account_circle,
            ),
            _campo(
              'Contraseña',
              claveController,
              icono: Icons.lock,
              oculto: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: guardar,
              icon: const Icon(Icons.save),
              label: Text(
                esEdicion ? 'Guardar cambios' : 'Registrar persona',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(
      String etiqueta,
      TextEditingController controller, {
        required IconData icono,
        TextInputType tipo = TextInputType.text,
        bool oculto = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        obscureText: oculto,
        validator: validarTexto,
        decoration: InputDecoration(
          labelText: etiqueta,
          prefixIcon: Icon(icono),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}