import 'package:flutter/material.dart';

class DigitalPrescriptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recetas Digitales"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text("Receta para Max"),
            subtitle: Text("Fecha: 01/01/2024"),
            trailing: Icon(Icons.file_copy),
            onTap: () {
              // Acción para ver detalles de la receta
            },
          ),
          // Añadir más ListTile para otras recetas
        ],
      ),
    );
  }
}
