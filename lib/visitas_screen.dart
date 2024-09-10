// lib/screens/visitas_screen.dart
import 'package:flutter/material.dart';

class VisitasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visitas Programadas"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildVisitaCard("Consulta con Dr. Smith", "20 de Septiembre, 2024", "Hora: 10:00 AM"),
          _buildVisitaCard("Chequeo general", "25 de Septiembre, 2024", "Hora: 2:00 PM"),
          // Agrega más visitas programadas según sea necesario
        ],
      ),
    );
  }

  Widget _buildVisitaCard(String service, String date, String time) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(service, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Fecha: $date\n$time"),
      ),
    );
  }
}
