import 'package:flutter/material.dart';

class SupportTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soporte Técnico"),
      ),
      body: Center(
        child: Text("Aquí puedes gestionar tickets de soporte técnico."),
      ),
    );
  }
}
