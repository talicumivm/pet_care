import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  final DateTime selectedDay;

  BookingDetailsPage({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Reserva"),
      ),
      body: Center(
        child: Text(
          'Detalles de la reserva para: ${selectedDay.toLocal()}',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
