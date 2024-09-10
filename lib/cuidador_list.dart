// lib/screens/pet_list.dart
import 'package:flutter/material.dart';
import 'package:pet_care/cuidador_profile.dart';
import '../models/cuidador.dart'; 
import 'cuidador_profile.dart'; 

class cuidadorList extends StatelessWidget {
  // Lista de mascotas
  final List<Cuidador> cuidador = [
    Cuidador(
      name: "Rocky",
      imagePath: "assets/husky.png",
      type: "human",
      servicios: "Only Fans",
    
    ),
    Cuidador(
      name: "Bella",
      imagePath: "assets/cat.png",
      type: "human",
      servicios: "Maraqueando",
   
    ),
    Cuidador(
      name: "Blanquito",
      imagePath: "assets/rabbit.png",
      type: "human",
      servicios: "bañador",
     
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Cuidadores"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: cuidador.length,
        itemBuilder: (context, index) {
          final cuidador = cuidador[index];
          return _buildcuidadorCard(context, cuidador);
        },
      ),
    );
  }

  Widget _buildcuidadorCard(BuildContext context, Cuidador cuidador) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(cuidador.imagePath),
        title: Text(cuidador.name, style: TextStyle(fontSize: 20)),
        subtitle: Text(cuidador.type),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CuidadorProfile(cuidador: cuidador),
            ),
          );
        },
      ),
    );
  }
}
