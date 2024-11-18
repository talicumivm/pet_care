import 'package:flutter/material.dart';

class BaseDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Base Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text("Aquí estará el contenido base."),
      ),
    );
  }
}
