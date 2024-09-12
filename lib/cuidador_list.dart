import 'package:flutter/material.dart';

class CuidadorList extends StatelessWidget {
  final String serviceType;

  CuidadorList({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de $serviceType"),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Aquí puedes cargar la lista de cuidadores/paseadores/entrenadores según el tipo de servicio
          _buildCuidadorOption("Juan Pérez", "Cuidador de perros"),
          _buildCuidadorOption("Ana López", "Entrenador de perros"),
          // Agrega más opciones según el servicio
        ],
      ),
    );
  }

  // Función para construir una opción de cuidador/paseador/entrenador
  Widget _buildCuidadorOption(String name, String specialty) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(name),
        subtitle: Text(specialty),
        onTap: () {
          // Acción al seleccionar un cuidador/paseador/entrenador
        },
      ),
    );
  }
}
