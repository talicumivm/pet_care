import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Importar el paquete http
import 'dart:convert';  // Para parsear la respuesta JSON
import 'models/user_manager.dart';
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

  // Lista para almacenar las citas obtenidas desde el backend
  List<Map<String, dynamic>> _appointmentsList = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointmentsData();  // Llamamos a la función de la solicitud HTTP
  }

  // Función para hacer la solicitud HTTP
  Future<void> _fetchAppointmentsData() async {
    final userManager = UserManager.instance;
    final userId = userManager.id ?? 'defaultUserId';  // Obtenemos el ID del usuario
    final url = 'http://127.0.0.1:8000/api/citas/$userId/user';  // URL con el ID del usuario

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final citasEncontradas = data['citas encontradas'] as List;

        print("Citas encontradas: $citasEncontradas"); // Verifica las citas antes de setState

        setState(() {
          _appointmentsList = citasEncontradas.map((cita) {
            return {
              'id': cita['id'],
              'fecha': cita['fecha'],
              'hora': cita['hora'],
              'id_mascota': cita['id_mascota'],
              'id_servicio': cita['id_servicio'],
            };
          }).toList();
        });
      } else {
        print("Error en la solicitud: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al hacer la solicitud: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userManager = UserManager.instance;
    final userEmail = userManager.email ?? 'Correo no disponible';
    final userRole = userManager.role ?? 'Rol no disponible';

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
    // Aquí mostramos las citas con la fecha y la hora
    print("Tamaño de la lista de citas: ${_appointmentsList.length}");

    if (_appointmentsList.isEmpty) {
      return Center(
        child: Text('No hay citas para este día'),
      );
    }

    return ListView.builder(
      itemCount: _appointmentsList.length,
      itemBuilder: (context, index) {
        final appointment = _appointmentsList[index];
        return ListTile(
          title: Text('Fecha: ${appointment['fecha']}'),
          subtitle: Text('Hora: ${appointment['hora']}'),
          trailing: Text('ID: ${appointment['id']}'),
        );
      },
    );
  }
}
