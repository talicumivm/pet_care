import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String service;

  ChatPage({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat sobre $service"),
      ),
      body: Center(
        child: Text("Chat con el profesional del servicio $service"),
      ),
    );
  }
}
