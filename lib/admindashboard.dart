import 'package:flutter/material.dart';
import 'report_list.dart';
import 'petlist.dart';
import 'user_list.dart';
import 'statistics_panel.dart'; // Importa la pantalla de estadísticas
import 'role_management.dart'; // Importa la pantalla de gestión de roles
import 'notifications_page.dart'; // Importa la pantalla de notificaciones
import 'services_management.dart'; // Importa la pantalla de gestión de servicios
import 'app_settings.dart'; // Importa la pantalla de configuración de la aplicación

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
          _buildAdminOption(context, Icons.pie_chart, "Estadísticas", StatisticsPage()), // Pantalla de estadísticas
          _buildAdminOption(context, Icons.lock, "Gestión de Roles", RoleManagement()), // Pantalla de gestión de roles
          _buildAdminOption(context, Icons.notifications, "Notificaciones", NotificationsPage()), // Pantalla de notificaciones
          _buildAdminOption(context, Icons.settings, "Configuración", AppSettings()), // Pantalla de configuración
          _buildAdminOption(context, Icons.people, "Usuarios", UserList()), // Pantalla de usuarios
          _buildAdminOption(context, Icons.report, "Reportes", ReportList()), // Pantalla de reportes
          _buildAdminOption(context, Icons.card_travel, "Servicios", ServicesManagement()), // Pantalla de servicios
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
