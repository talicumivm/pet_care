import 'package:flutter/material.dart';
import 'report_list.dart';
import 'petlist.dart';
import 'user_list.dart';
import 'role_management.dart'; // Importa la pantalla de gestión de roles

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

          _buildAdminOption(context, Icons.lock, "Gestión de Roles", RoleManagement()), // Pantalla de gestión de roles
          _buildAdminOption(context, Icons.people, "Usuarios", UserList()), // Pantalla de usuarios
          _buildAdminOption(context, Icons.report, "Reportes", ReportList()), // Pantalla de reportes
        ],
      ),
    );
  }

  // Esta función construye cada opción del menú de administrador
  Widget _buildAdminOption(BuildContext context, IconData icon, String label, Widget page) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(label, style: TextStyle(fontSize: 20)),
      onTap: () {
        // Navegación a la pantalla correspondiente
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
