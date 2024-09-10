// lib/screens/report_list.dart
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Reportes"),
      ),
      body: Center(
        child: Text("Aquí van los reportes."),
      ),
    );
  }
}
