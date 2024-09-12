import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'cuidador_list.dart'; // Asegúrate de que este archivo exista y contenga la pantalla de cuidadores

class OwnerDashboard extends StatefulWidget {
  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _selectedSpecialistType = '';
  String _specialistDetails = '';
  late Map<DateTime, List<String>> _events;

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
        title: Text("Dueño de Mascotas"),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Acción para el botón de calendario (opcional)
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen, // Color verde para el botón
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              _showAddPetDialog();
            },
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
            height: 400, // Ajusta la altura según tus necesidades
            child: _buildCalendar(),
          ),
          
          SizedBox(height: 20),
          Text("Detalles de la cita", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(_specialistDetails, style: TextStyle(fontSize: 16)),
        ],
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
          MaterialPageRoute(builder: (context) => CuidadorList(serviceType: serviceName)),
        );
        break;
     
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio de $serviceName seleccionado.')));
    }
  }

  void _showVetSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Seleccionar Veterinario"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildVetOption("Dr. Juan Pérez", "Veterinario General", () {
                  Navigator.pop(context);
                  _showCalendar("Veterinario", "Dr. Juan Pérez");
                }),
                _buildVetOption("Dra. Ana López", "Especialista en Caninos", () {
                  Navigator.pop(context);
                  _showCalendar("Veterinario", "Dra. Ana López");
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVetOption(String name, String specialty, VoidCallback onTap) {
    return ListTile(
      title: Text(name),
      subtitle: Text(specialty),
      onTap: onTap,
    );
  }

  void _showCalendar(String type, String specialist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Seleccionar Fecha y Hora"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300, // Ajusta la altura según tus necesidades
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _specialistDetails = "Especialista: $specialist\nFecha: ${_selectedDate.toLocal()}";
                    });
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_events[_selectedDate] == null) {
                      _events[_selectedDate] = [];
                    }
                    _events[_selectedDate]!.add('Cita con $specialist');
                    _specialistDetails = "Especialista: $specialist\nFecha: ${_selectedDate.toLocal()}";
                  });
                  Navigator.pop(context);
                },
                child: Text("Guardar Cita"),
              ),
            ],
          ),
        );
      },
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
          _specialistDetails = _events[_selectedDate]?.join('\n') ?? 'No hay citas para esta fecha';
        });
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
    );
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
                // Agrega aquí más campos según sea necesario
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Guarda la información de la mascota
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
