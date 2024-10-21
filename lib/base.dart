import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BaseDashboard extends StatefulWidget {
  final String title;
  final Color backgroundColor;

  const BaseDashboard({required this.title, required this.backgroundColor});

  @override
  _BaseDashboardState createState() => _BaseDashboardState();
}

class _BaseDashboardState extends State<BaseDashboard> {
  DateTime _selectedDate = DateTime.now();
  late Map<DateTime, List<String>> _events;
  String _details = '';

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Cita con el Dr. Juan Pérez'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.backgroundColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildCalendar(),
          SizedBox(height: 20),
          Text("Detalles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(_details, style: TextStyle(fontSize: 16)),
        ],
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
          _details = _events[_selectedDate]?.join('\n') ?? 'No hay citas para esta fecha';
        });
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
    );
  }
}
