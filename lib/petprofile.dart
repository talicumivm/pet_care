// lib/screens/pet_profile.dart
import 'package:flutter/material.dart';
import '../models/pet.dart'; // Importa la clase Pet

class PetProfile extends StatelessWidget {
  final Pet pet;

  PetProfile({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey[200], // Fondo gris claro en lugar de imagen
                radius: 100,
                child: Icon(Icons.pets, size: 100, color: Colors.black), // Reemplaza la imagen con un ícono por ahora
              ),
            ),
            SizedBox(height: 20),
            Text('Nombre: ${pet.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Tipo: ${pet.type}', style: TextStyle(fontSize: 18)),
            Text('Raza: ${pet.breed}', style: TextStyle(fontSize: 18)),
            Text('Peso: ${pet.weight}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
