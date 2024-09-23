import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WalkerDashboard extends StatefulWidget {
  @override
  _WalkerDashboardState createState() => _WalkerDashboardState();
}

class _WalkerDashboardState extends State<WalkerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _walkerDetails = '';
  late Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Paseo con el Sr. Carlos Martínez'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de Paseador"),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Text("Calendario de Paseos", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            height: 400,
            child: _buildCalendar(),
          ),
          SizedBox(height: 20),
          Text("Detalles del Paseo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(_walkerDetails, style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          _buildStatsCard(),
          SizedBox(height: 20),
          _buildFeedbackCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSessionDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
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
          _walkerDetails = _events[_selectedDate]?.join('\n') ?? 'No hay paseos para esta fecha';
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
          title: Text("Agregar Paseo"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Nombre del Paseador"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Detalles del Paseo"),
                ),
                // Agrega aquí más campos según sea necesario
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
                  _events[_selectedDate]!.add('Paseo con el Sr. Carlos Martínez');
                  _walkerDetails = "Paseador: Sr. Carlos Martínez\nFecha: ${_selectedDate.toLocal()}";
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

  Widget _buildStatsCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text("Estadísticas de Paseos"),
        subtitle: Text("Total de paseos: 10\nDuración promedio: 30 min\n  Kilometros:10\n Mascotas frecuentes: Max, Luna "),
        onTap: () {
          // Acción al tocar el card de estadísticas
        },
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text("Comentarios y Calificaciones"),
        subtitle: Text("Max: 5 estrellas\nLuna: 4 estrellas"),
        onTap: () {
          // Acción al tocar el card de comentarios
        },
      ),
    );
  }
}
