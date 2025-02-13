class JuegoSignificadoData {
  static final List<NivelSignificado> niveles = [
    NivelSignificado(
      nivel: 1,
      palabraCorrecta: "CASA",
      imagenes: generarImagenes("CASA"),
    ),
    NivelSignificado(
      nivel: 2,
      palabraCorrecta: "AGUA",
      imagenes: generarImagenes("AGUA"),
    ),
    NivelSignificado(
      nivel: 3,
      palabraCorrecta: "MESA",
      imagenes: generarImagenes("MESA"),
    ),
    NivelSignificado(
      nivel: 4,
      palabraCorrecta: "SOPA",
      imagenes: generarImagenes("SOPA"),
    ),
    NivelSignificado(
      nivel: 5,
      palabraCorrecta: "MAMA",
      imagenes: generarImagenes("MAMA"),
    ),
    NivelSignificado(
      nivel: 6,
      palabraCorrecta: "PAPA",
      imagenes: generarImagenes("PAPA"),
    ),
    NivelSignificado(
      nivel: 7,
      palabraCorrecta: "MANO",
      imagenes: generarImagenes("MANO"),
    ),
  ];

  // Genera la lista de imágenes a partir de la palabra correcta
  static List<String> generarImagenes(String palabra) {
    return palabra
        .split("")
        .map((letra) => "${letra.toLowerCase()}.png")
        .toList();
  }
}

class NivelSignificado {
  final int nivel;
  final String palabraCorrecta;
  final List<String> imagenes;

  NivelSignificado({
    required this.nivel,
    required this.palabraCorrecta,
    required this.imagenes,
  });
}
