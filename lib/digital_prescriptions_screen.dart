import 'package:flutter/material.dart';

class DigitalPrescriptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recetas Digitales"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text("Aquí se mostrarán las recetas digitales."),
      ),
    );
  }
}
