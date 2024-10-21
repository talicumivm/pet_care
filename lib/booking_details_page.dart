import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  final DateTime selectedDay;

  BookingDetailsPage({required this.selectedDay});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;  // Inicializa con la fecha seleccionada original
  }

  // Función para mostrar un selector de fecha y actualizar la fecha seleccionada
  Future<void> _selectNewDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay,  // Fecha inicial
      firstDate: DateTime(2023),  // Fecha mínima seleccionable
      lastDate: DateTime(2025),   // Fecha máxima seleccionable
    );
    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;  // Actualiza la fecha seleccionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Reserva"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Detalles de la reserva para: ${_selectedDay.toLocal()}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectNewDate(context),  // Llama al selector de fecha
              child: Text('Cambiar Fecha'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar la nueva fecha de la reserva
                Navigator.pop(context, _selectedDay);  // Devolver la nueva fecha
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
