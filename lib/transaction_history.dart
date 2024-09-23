import 'package:flutter/material.dart';

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Transacciones"),
      ),
      body: Center(
        child: Text("Aquí puedes revisar las transacciones realizadas en la plataforma."),
      ),
    );
  }
}
