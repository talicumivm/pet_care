import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Administrador"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildAdminOption(Icons.pets, "Mascotas"),
          _buildAdminOption(Icons.people, "Usuarios"),
          _buildAdminOption(Icons.report, "Reportes"),
        ],
      ),
    );
  }

  Widget _buildAdminOption(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(label, style: TextStyle(fontSize: 20)),
      onTap: () {
        // Acción al hacer clic en la opción
      },
    );
  }
}
