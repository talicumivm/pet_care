import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de Estadísticas"),
      ),
      body: Center(
        child: Text("Aquí puedes ver estadísticas generales de la plataforma."),
      ),
    );
  }
}
