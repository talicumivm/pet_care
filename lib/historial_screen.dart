// lib/screens/historial_screen.dart
import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Mascotas"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildHistorialCard("Consulta de rutina", "10 de Septiembre, 2024", "Veterinario: Dr. Smith"),
          _buildHistorialCard("Vacunación", "5 de Agosto, 2024", "Veterinario: Dr. Smith"),
          _buildHistorialCard("Revisión dental", "15 de Julio, 2024", "Veterinario: Dr. Johnson"),
          // Agrega más registros según sea necesario
        ],
      ),
    );
  }

  Widget _buildHistorialCard(String service, String date, String vet) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(service, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Fecha: $date\n$vet"),
      ),
    );
  }
}
