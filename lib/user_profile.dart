// lib/screens/user_profile.dart
import 'package:flutter/material.dart';
import '../models/user.dart'; // Asegúrate de importar la clase User

class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(user.imagePath, height: 200, width: 200),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre: ${user.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Correo: ${user.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Rol: ${user.role}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
