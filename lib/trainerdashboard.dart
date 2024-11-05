import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrainerDashboard extends StatefulWidget {
  @override
  _TrainerDashboardState createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _trainerDetails = '';
  late Map<DateTime, List<String>> _events;
  late GoogleMapController _mapController;
  static const LatLng _center = LatLng(-33.4489, -70.6693); // Ubicación predeterminada

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Sesión de entrenamiento con el Sr. Luis Gómez'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de Entrenador"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Text("Calendario de Entrenamientos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            height: 400,
            child: _buildCalendar(),
          ),
          SizedBox(height: 20),
          Text("Detalles del entrenamiento", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(_trainerDetails, style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text("Ubicación del Entrenamiento", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            height: 300,
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSessionDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _trainerDetails = _events[_selectedDate]?.join('\n') ?? 'No hay sesiones para esta fecha';
        });
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
    );
  }

  void _showAddSessionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar Sesión de Entrenamiento"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Nombre del Entrenador"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Tipo de Entrenamiento"),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_events[_selectedDate] == null) {
                    _events[_selectedDate] = [];
                  }
                  _events[_selectedDate]!.add('Sesión con el Sr. Luis Gómez');
                  _trainerDetails = "Entrenador: Sr. Luis Gómez\nFecha: ${_selectedDate.toLocal()}";
                });
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
