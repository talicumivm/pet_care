import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),
      ),
      body: Center(
        child: Text("No tienes notificaciones nuevas"),
      ),
    );
  }
}
