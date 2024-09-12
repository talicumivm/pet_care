import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final List<DateTime> _appointments = []; // Lista de citas agendadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citas Agendadas"),
        backgroundColor: Colors.blueAccent,
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
              _showAppointmentsForDay(selectedDay);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return _appointments.where((appointment) => isSameDay(day, appointment)).toList();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final appointment = _appointments[index];
                return ListTile(
                  title: Text('Cita: ${appointment.toLocal()}'),
                  // Agregar detalles de la cita aquí
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAppointmentsForDay(DateTime day) {
    // Lógica para mostrar citas del día seleccionado
    print("Mostrando citas para el día: $day");
  }
}
