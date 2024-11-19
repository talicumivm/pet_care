import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsScreen extends StatefulWidget {
  // final Map<DateTime, List<String>> appointments; // Mapa de citas recibido como parámetro

  // AppointmentsScreen();

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Lista para almacenar las citas obtenidas desde el backend
  List<Map<String, dynamic>> _appointmentsList = [];

   // Conjunto de días ocupados
  Set<DateTime> _occupiedDays = Set();

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

            // Agregamos las fechas de las citas al conjunto de días ocupados
          _occupiedDays.clear(); // Limpiamos el conjunto de días ocupados

          // Preprocesamos las citas para agregarlas al mapa de eventos
          for (var cita in _appointmentsList) {
            final fecha = cita['fecha'];
            final date = DateTime.parse(fecha); // Convertimos la fecha en un DateTime

            // Convertimos la fecha a solo año, mes, día para marcarla
            final fechaSoloDia = DateTime(date.year, date.month, date.day);

            _occupiedDays.add(fechaSoloDia);  // Marcamos el día como ocupado
          }
        print("Días ocupados: $_occupiedDays");
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
              // Usamos el conjunto _occupiedDays para obtener los eventos del día
              return _occupiedDays.contains(DateTime(day.year, day.month, day.day)) ? ['Cita ocupada'] : [];
            },
            calendarBuilders: CalendarBuilders(
              // Aquí cambiamos el fondo de los días ocupados
              defaultBuilder: (context, day, focusedDay) {
                // Si el día está en _occupiedDays, le damos un fondo azul
                return Container(
                  decoration: BoxDecoration(
                    color: _occupiedDays.contains(day) ? Colors.blue : null, // Fondo azul si está ocupado
                    borderRadius: BorderRadius.circular(8), // Redondeamos las esquinas
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.black, // Texto blanco para los días ocupados
                      ),
                    ),
                  ),
                );
              },
            ),
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
