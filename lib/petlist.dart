// lib/screens/pet_list.dart
import 'package:flutter/material.dart';
import '../models/pet.dart'; // Importa la clase Pet
import 'petprofile.dart'; // Asegúrate de importar la pantalla de perfil de mascota

class PetList extends StatelessWidget {
  // Lista de mascotas
  final List<Pet> pets = [
    Pet(
      name: "Rocky",
      imagePath: "assets/husky.png",
      type: "Perro",
      breed: "Siberiano",
      weight: "30 kg",
    ),
    Pet(
      name: "Bella",
      imagePath: "assets/cat.png",
      type: "Gato",
      breed: "Siames",
      weight: "5 kg",
    ),
    Pet(
      name: "Blanquito",
      imagePath: "assets/rabbit.png",
      type: "Conejo",
      breed: "Holland Lop",
      weight: "2 kg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Mascotas"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return _buildPetCard(context, pet);
        },
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Pet pet) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.pets, size: 50), // Reemplaza la imagen con un ícono por ahora
        title: Text(pet.name, style: TextStyle(fontSize: 20)),
        subtitle: Text(pet.type),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfile(pet: pet),
            ),
          );
        },
      ),
    );
  }
}
