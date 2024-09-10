// lib/screens/salud_screen.dart
import 'package:flutter/material.dart';

class SaludScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSaludCard("Vacunas"),
          _buildSaludCard("Desparasitante"),
          _buildSaludCard("Exámenes"),
          _buildSaludCard("Recetas"),
          _buildSaludCard("Desparasitante"),
          // Agrega más registros de salud según sea necesario
        ],
      ),
    );
  }

  Widget _buildSaludCard(String service) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(service, style: TextStyle(fontWeight: FontWeight.bold)),
        
      ),
    );
  }
}
