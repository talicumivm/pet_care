// lib/screens/user_list.dart
import 'package:flutter/material.dart';
import '../models/user.dart'; // Importa la clase User
import 'user_profile.dart'; // Importa la pantalla de perfil de usuario

class UserList extends StatelessWidget {
  // Lista de usuarios de ejemplo
  final List<User> users = [
    User(
      name: "Juan Perez",
      imagePath: "assets/user1.png",
      email: "juan.perez@example.com",
      role: "Administrador",
    ),
    User(
      name: "Maria López",
      imagePath: "assets/user2.png",
      email: "maria.lopez@example.com",
      role: "Cliente",
    ),
    User(
      name: "Carlos García",
      imagePath: "assets/user3.png",
      email: "carlos.garcia@example.com",
      role: "Veterinario",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(context, user);
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, User user) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(user.imagePath, width: 50, height: 50),
        title: Text(user.name, style: TextStyle(fontSize: 20)),
        subtitle: Text(user.role),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(user: user),
            ),
          );
        },
      ),
    );
  }
}
