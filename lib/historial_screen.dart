import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text("Aquí se mostrará el historial de la mascota."),
      ),
    );
  }
}
