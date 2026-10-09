import 'package:flutter/material.dart';
import '../screens/screens.dart';

class ListaPersonas extends StatefulWidget {
  const ListaPersonas({super.key});

  @override
  State<ListaPersonas> createState() =>
      _ListaPersonasScreenState();
}

class _ListaPersonasScreenState extends State<ListaPersonas> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (UsuariosMemoria.usuarioActual?.rol != 'Administrador') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
              (route) => false,
        );
      });
    }
  }

  Future<void> abrirFormulario() async {
    final resultado = await Navigator.pushNamed(
      context,
      '/formulario',
    );

    if (!mounted) return;

    if (resultado == true) {
      setState(() {});
    }
  }

  Future<void> abrirDetalle(persona) async {
    await Navigator.pushNamed(
      context,
      '/detalle',
      arguments: persona,
    );

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (UsuariosMemoria.usuarioActual?.rol != 'Administrador') {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final personas = UsuariosMemoria.personas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personas registradas'),
      ),
      body: personas.isEmpty
          ? const Center(
        child: Text('No hay personas registradas.'),
      )
          : ListView.builder(
        itemCount: personas.length,
        itemBuilder: (context, index) {
          final persona = personas[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  persona.Nombre.isNotEmpty
                      ? persona.Nombre[0].toUpperCase()
                      : '?',
                ),
              ),
              title: Text(persona.Nombre),
              subtitle: Text(
                '${persona.correo}\nRol: ${persona.rol}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => abrirDetalle(persona),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: abrirFormulario,
        icon: const Icon(Icons.person_add),
        label: const Text('Registrar'),
      ),
    );
  }
}