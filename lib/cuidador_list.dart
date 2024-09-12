import 'package:flutter/material.dart';
import 'package:pet_care/cuidador_profile.dart';
import '../models/cuidador.dart'; 

class CuidadorList extends StatelessWidget {
  // Lista de cuidadores con calificación
  final List<Cuidador> cuidadores = [
    Cuidador(
      name: "Juanito Perez",
      imagePath: "assets/imagenes/cuidador-de-perros.png",
      type: "Especialista en Higiene",
      servicios: "Bañador",
      rating: 4.5, // Ejemplo de calificación
    ),
    Cuidador(
      name: "Andrea Gonzalez",
      imagePath: "assets/imagenes/cuidador-de-perros.png",
      type: "Especialista Capilar",
      servicios: "Peluquero",
      rating: 4.8, // Ejemplo de calificación
    ),
    Cuidador(
      name: "Marisol Vasquez",
      imagePath: "assets/imagenes/cuidador-de-perros.png",
      type: "Especialista en Estilo",
      servicios: "Estilista",
      rating: 4.2, // Ejemplo de calificación
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
        itemCount: cuidadores.length,
        itemBuilder: (context, index) {
          final cuidador = cuidadores[index];
          return _buildCuidadorCard(context, cuidador);
        },
      ),
    );
  }

  Widget _buildCuidadorCard(BuildContext context, Cuidador cuidador) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(cuidador.imagePath),
        title: Text(cuidador.name, style: TextStyle(fontSize: 20)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cuidador.type),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16),
                SizedBox(width: 5),
                Text(cuidador.rating.toString(), style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
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
