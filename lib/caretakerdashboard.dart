import 'package:flutter/material.dart';

class CaretakerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Cuidador"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Registro de Actividades", style: TextStyle(fontSize: 24)),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text("Alimentación"),
            subtitle: Text("Última comida: 9 AM"),
          ),
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text("Ejercicio"),
            subtitle: Text("Última caminata: 7 AM"),
          ),
          ListTile(
            leading: Icon(Icons.water),
            title: Text("Agua"),
            subtitle: Text("Última vez: 10 AM"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar nueva actividad
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
