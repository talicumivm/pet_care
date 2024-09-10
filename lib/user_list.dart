// lib/screens/user_list.dart
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
      ),
      body: Center(
        child: Text("Aquí va la lista de usuarios."),
      ),
    );
  }
}
