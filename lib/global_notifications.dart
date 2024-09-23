import 'package:flutter/material.dart';

class GlobalNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones Globales"),
      ),
      body: Center(
        child: Text("Aquí puedes enviar notificaciones a todos los usuarios."),
      ),
    );
  }
}
