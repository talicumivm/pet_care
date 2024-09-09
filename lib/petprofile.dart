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
                backgroundImage: AssetImage(pet.imagePath),
                radius: 100,
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
