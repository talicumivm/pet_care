import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'booking_details_page.dart'; // Página para ver detalles de una cita
import 'models/Appointment.dart'; // Clase Appointment

class CalendarPage extends StatefulWidget {
  final String title;       // Título de la página (personalizable)
  final Color color;        // Color de la barra superior (personalizable)
  final Map<DateTime, List<Appointment>> appointments;  // Citas por fecha

  CalendarPage({required this.title, required this.color, required this.appointments});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();   // Día focalizado en el calendario
  DateTime? _selectedDay;                  // Día seleccionado en el calendario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,  
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
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
              return widget.appointments[day] ?? [];
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildAppointmentList(),
          ),
        ],
      ),
    );
  }

  // Función para construir la lista de citas para el día seleccionado
  Widget _buildAppointmentList() {
    // Obtener citas para el día seleccionado
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
          title: Text(appointment.title),
          subtitle: Text(appointment.description),
          onTap: () {
            // Al hacer clic en una cita, navegar a la página de detalles de la cita
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingDetailsPage(selectedDay: appointment.time),
              ),
            );
          },
        );
      },
    );
  }

  void _showAppointmentsForDay(DateTime day) {
    // Aquí podrías mostrar más detalles o manejar acciones específicas para el día seleccionado
    print("Mostrando citas para el día: $day");
  }
}
