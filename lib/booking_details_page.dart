import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  final DateTime selectedDay;

  BookingDetailsPage({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha de la cita: ${selectedDay.toLocal()}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
