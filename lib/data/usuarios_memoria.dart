import '../models/persona.dart';
import '../screens/screens.dart';

class UsuariosMemoria {
  static final List<Persona> personas = [
    Persona(
      Nombre: 'Administrador',
      Edad: 30,
      correo: 'admin@correo.com',
      telefono: '3000000000',
      Usuario: 'admin',
      Clave: 'admin123',
      rol: 'Administrador',
    ),
    Persona(
      Nombre: 'Juan Pérez',
      Edad: 25,
      correo: 'juan@correo.com',
      telefono: '3100000000',
      Usuario: 'juan',
      Clave: 'juan123',
      rol: 'Persona',
    ),
  ];

  static Persona? usuarioActual;

  static Persona? iniciarSesion(String usuario, String clave) {
    for (final persona in personas) {
      if (persona.Usuario == usuario && persona.Clave == clave) {
        usuarioActual = persona;
        return persona;
      }
    }

    return null;
  }

  static void cerrarSesion() {
    usuarioActual = null;
  }

  static void agregarPersona(Persona persona) {
    personas.add(persona);
  }
}