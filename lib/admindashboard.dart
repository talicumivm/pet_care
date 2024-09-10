// lib/screens/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'petlist.dart'; // Asegúrate de importar la pantalla de lista de mascotas
import 'user_list.dart'; // Asegúrate de importar la pantalla de lista de usuarios
import 'report_list.dart'; // Asegúrate de importar la pantalla de reportes

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
          _buildAdminOption(context, Icons.pets, "Mascotas", PetList()),
          _buildAdminOption(context, Icons.people, "Usuarios", UserList()),
          _buildAdminOption(context, Icons.report, "Reportes", ReportList()),
        ],
      ),
    );
  }

  Widget _buildAdminOption(BuildContext context, IconData icon, String label, Widget page) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(label, style: TextStyle(fontSize: 20)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
