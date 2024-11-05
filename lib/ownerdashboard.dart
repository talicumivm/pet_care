import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_appointment_dialog.dart'; // Importar el diálogo para agregar citas
import 'package:intl/intl.dart'; // Para formatear la fecha y la hora
import 'cuidador_list.dart';

class OwnerDashboard extends StatefulWidget {
  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _specialistDetails = '';
  late Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Cita con el Dr. Juan Pérez a las 10:00 AM'],
      DateTime.now().add(Duration(days: 2)): ['Entrenamiento con Pedro a las 14:00 PM'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dueño de Mascotas"),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(fontSize: 16),
            ),
            onPressed: _showAddPetDialog,
            child: Text("Agregar Mascota"),
          ),
          SizedBox(height: 20),
          Text("Servicios disponibles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildServiceCard(context, "Cuidado de mascotas", Icons.pets, "Reservar servicio de cuidado"),
          _buildServiceCard(context, "Entrenamiento", Icons.directions_run, "Reservar servicio de entrenamiento"),
          _buildServiceCard(context, "Paseo", Icons.directions_walk, "Reservar servicio de paseo"),
          _buildServiceCard(context, "Veterinario", Icons.local_hospital, "Seleccionar veterinario"),
          SizedBox(height: 30),
          Text("Calendario", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            height: 400,
            child: _buildCalendar(),
          ),
          SizedBox(height: 20),
          Text("Detalles de la cita", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(_specialistDetails, style: TextStyle(fontSize: 16)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAppointment,  // Lógica para añadir citas
        child: Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String serviceName, IconData icon, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.lightGreen),
        title: Text(serviceName, style: TextStyle(fontSize: 20)),
        subtitle: Text(description),
        onTap: () {
          _selectService(context, serviceName);
        },
      ),
    );
  }

  void _selectService(BuildContext context, String serviceName) {
    switch (serviceName) {
      case "Cuidado de mascotas":
      case "Entrenamiento":
      case "Paseo":
      case "Veterinario":
       Navigator.push(
        context,
         MaterialPageRoute(builder: (context) => CuidadorList()),
         );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio de $serviceName seleccionado.')));
    }
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _selectedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _specialistDetails = _events[_selectedDate]?.join('\n') ?? 'No hay citas para esta fecha';
        });
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
    );
  }

  // Lógica para agregar una nueva cita
  Future<void> _addNewAppointment() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddAppointmentDialog(selectedDay: _selectedDate),
    );

    if (result != null && result.containsKey('title')) {
      setState(() {
        if (_events[_selectedDate] == null) {
          _events[_selectedDate] = [];
        }
        // Formatear la fecha y hora para mostrarla
        String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(result['datetime']);
        // Agregar la nueva cita con fecha y hora
        _events[_selectedDate]!.add('${result['title']} - ${result['description']} a las $formattedDateTime');
        _specialistDetails = _events[_selectedDate]!.join('\n'); // Actualizar los detalles de la cita
      });
    }
  }

  void _showAddPetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar Mascota"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Raza"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Peso (kg)"),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Tipo de animal"),
                  items: <String>['Perro', 'Gato', 'Pájaro'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar la información de la mascota
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
