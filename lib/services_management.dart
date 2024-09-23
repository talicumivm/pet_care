import 'package:flutter/material.dart';

class ServicesManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Servicios"),
      ),
      body: Center(
        child: Text("Aquí puedes agregar, editar o eliminar servicios."),
      ),
    );
  }
}
