// lib/models/user.dart
class User {
  final String name;
  final String imagePath;
  final String email;
  final String role; // Tipo de usuario (e.g., administrador, cliente)
  
  User({
    required this.name,
    required this.imagePath,
    required this.email,
    required this.role,
  });
}
