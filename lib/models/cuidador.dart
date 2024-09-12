// lib/models/cuidador.dart
class Cuidador {
  final String name;
  final String imagePath;
  final String type;
  final String servicios;
  final double rating; // Nueva propiedad para la calificación

  Cuidador({
    required this.name,
    required this.imagePath,
    required this.type,
    required this.servicios,
    this.rating = 0.0, // Valor por defecto de la calificación
  });
}
