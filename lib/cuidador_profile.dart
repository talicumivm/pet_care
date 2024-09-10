// lib/screens/pet_list.dart
import 'package:flutter/material.dart';
import '../models/cuidador.dart'; // Importa la clase Pet
import 'cuidador_list.dart'; // Asegúrate de importar la pantalla de perfil de mascota

class CuidadorProfile extends StatelessWidget {
  // Lista de mascotas
  final List<Cuidador> cuidador= [
    Cuidador(
      name: "Rocky",
      imagePath: "assets/husky.png",
      type: "Perro",
      servicios: "Siberiano",
     
    ),
    Cuidador(
      name: "Bella",
      imagePath: "assets/cat.png",
      type: "Gato",
      servicios: "Siames",
     
    Cuidador(
      name: "Blanquito",
      imagePath: "assets/rabbit.png",
      type: "Conejo",
      servicios: "Holland Lop",
     
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
        itemCount: cuidador.length,
        itemBuilder: (context, index) {
          final pet = cuidador[index];
          return _buildPetCard(context, pet);
        },
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Cuidador cuidador) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(.imagePath),
        title: Text(cuidador.name, style: TextStyle(fontSize: 20)),
        subtitle: Text(cuidador.type),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CuidadorProfile(Cuidador: cuidador),
            ),
          );
        },
      ),
    );
  }
}
