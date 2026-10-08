class Persona
{
  String Nombre;
  int Edad;
  String correo;
  String Usuario;
  String Clave;
  String telefono;
  String rol;

  Persona
      (
        {
          required this.Nombre,
          required this.Edad,
          required this.rol,
          required this.correo,
          required this.telefono,
          required this.Usuario,
          required this.Clave

        }
      );
}