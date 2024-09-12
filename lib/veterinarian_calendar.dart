import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class VeterinarianCalendar extends StatefulWidget {
  @override
  _VeterinarianCalendarState createState() => _VeterinarianCalendarState();
}

class _VeterinarianCalendarState extends State<VeterinarianCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario del Veterinario"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              // Navegar a la selección de hora para la cita
              _showTimePicker(context);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        // Guardar la cita y actualizar la base de datos
        _saveAppointment(_selectedDay, time);
      }
    });
  }

  void _saveAppointment(DateTime date, TimeOfDay time) {
    // Implementar la lógica para guardar la cita
    final appointmentDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    print("Cita agendada para: $appointmentDateTime");
    // Actualizar la base de datos y mostrar un mensaje
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cita agendada para $appointmentDateTime')));
  }
}
