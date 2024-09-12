// lib/screens/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'report_list.dart';
import 'petlist.dart';
import 'user_list.dart'; // Importa la pantalla de lista de usuarios

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
          _buildAdminOption(context, Icons.pets, "Mascotas", PetList()), // Pantalla de mascotas
          _buildAdminOption(context, Icons.people, "Usuarios", UserList()), // Pantalla de usuarios
          _buildAdminOption(context, Icons.report, "Reportes", ReportList()), // Pantalla de reportes
          _buildAdminOption(context, Icons.calendar_today, "Creacion de Cuenta ", PetList()), // Pantalla de mascotas
          _buildAdminOption(context, Icons.add_circle_outline, "Creacion de Reserva", UserList()), // Pantalla de usuarios
          _buildAdminOption(context, Icons.favorite, "Creacion De Mascota", ReportList()), 
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
