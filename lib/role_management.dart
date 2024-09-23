import 'package:flutter/material.dart';

class RoleManagement extends StatefulWidget {
  @override
  _RoleManagementState createState() => _RoleManagementState();
}

class _RoleManagementState extends State<RoleManagement> {
  final List<String> _roles = ['Administrador', 'Veterinario', 'Cuidador', 'Paseador'];
  final Map<String, List<String>> _usersByRole = {
    'Administrador': ['Juan Pérez', 'Ana García'],
    'Veterinario': ['Dr. Luis Gómez', 'Dra. María Fernández'],
    'Cuidador': ['Pedro González', 'Laura López'],
    'Paseador': ['Carlos Ramírez', 'Marta Díaz'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Roles"),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: _roles.map((role) {
          return ExpansionTile(
            title: Text(role, style: TextStyle(fontSize: 20)),
            children: _usersByRole[role]!.map((user) {
              return ListTile(
                title: Text(user),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditRoleDialog(role, user);
                  },
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  void _showEditRoleDialog(String role, String user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Rol"),
          content: Text("¿Deseas cambiar el rol de $user?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Lógica para cambiar el rol
                Navigator.pop(context);
              },
              child: Text("Confirmar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
