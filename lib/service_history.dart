import 'package:flutter/material.dart';
import 'chat_page.dart';  // Asegúrate de que este archivo exista y esté en la ruta correcta

class ServiceHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Servicios"),
      ),
      body: ListView(
        children: [
          _buildServiceHistoryCard(context, "Consulta Veterinaria", "10 de Septiembre, 2024"),
          _buildServiceHistoryCard(context, "Entrenamiento", "15 de Agosto, 2024"),
          _buildServiceHistoryCard(context, "Paseo", "5 de Julio, 2024"),
        ],
      ),
    );
  }

  Widget _buildServiceHistoryCard(BuildContext context, String service, String date) {
    return Card(
      child: ListTile(
        title: Text(service),
        subtitle: Text(date),
        trailing: IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage(service: service)),
            );
          },
        ),
      ),
    );
  }
}
