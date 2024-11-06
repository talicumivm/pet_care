import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  final Map<DateTime, List<String>> appointments; // Mapa de citas recibido como parámetro

  AppointmentsScreen({required this.appointments});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Colocar el print aquí para verificar el contenido de appointments
    print("Mapa de citas (appointments): ${widget.appointments}");

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
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return widget.appointments[day] ?? [];
            },
          ),
          Expanded(
            child: _buildAppointmentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentList() {
    final appointmentsForSelectedDay = widget.appointments[_selectedDay] ?? [];

    if (appointmentsForSelectedDay.isEmpty) {
      return Center(
        child: Text('No hay citas para este día'),
      );
    }

    return ListView.builder(
      itemCount: appointmentsForSelectedDay.length,
      itemBuilder: (context, index) {
        final appointment = appointmentsForSelectedDay[index];
        return ListTile(
          title: Text(appointment),
        );
      },
    );
  }
}
