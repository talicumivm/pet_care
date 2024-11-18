import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorarioScreen extends StatelessWidget {
  final dynamic servicio;
  final Function(String horario) onHorarioSeleccionado; // Callback para seleccionar horario

  HorarioScreen({required this.servicio, required this.onHorarioSeleccionado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar ${servicio['tipo_de_servicio']}'),
      ),
      body: _buildHorarioList(context),
    );
  }

  Widget _buildHorarioList(BuildContext context) {
    // Generar horarios para las próximas dos semanas
    List<String> horarios = [];
    DateTime now = DateTime.now();
    DateTime end = now.add(Duration(days: 14));

    // Iterar desde las 10:00 AM hasta las 6:00 PM para cada día
    for (DateTime day = now; day.isBefore(end); day = day.add(Duration(days: 1))) {
      DateTime startTime = DateTime(day.year, day.month, day.day, 10, 0);
      DateTime endTime = DateTime(day.year, day.month, day.day, 18, 0);

      for (DateTime time = startTime; time.isBefore(endTime); time = time.add(Duration(minutes: 30))) {
        // Formatear el horario para mostrarlo de forma legible
        String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(time);
        horarios.add(formattedTime);
      }
    }

    return ListView.builder(
      itemCount: horarios.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Horario: ${horarios[index]}'),
          onTap: () {
            // Llamar al callback cuando se selecciona un horario
            onHorarioSeleccionado(horarios[index]);
            Navigator.pop(context); // Volver a la pantalla anterior
          },
        );
      },
    );
  }
}
