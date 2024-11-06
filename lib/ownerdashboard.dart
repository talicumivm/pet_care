import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'add_appointment_dialog.dart';
import 'cuidador_list.dart';
import 'package:http/http.dart' as http;
import 'horario_screen.dart';


class OwnerDashboard extends StatefulWidget {
  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _specialistDetails = '';
  late Map<DateTime, List<String>> _events;
  List<dynamic> _servicios = [];  // Lista de servicios obtenidos de la API

  @override
  void initState() {
    super.initState();
    _fetchServicios();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Cita con el Dr. Juan Pérez a las 10:00 AM'],
      DateTime.now().add(Duration(days: 2)): ['Entrenamiento con Pedro a las 14:00 PM'],
    };
  }

  // Función para obtener los servicios desde la API
  Future<void> _fetchServicios() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/servicios');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('Respuesta completa de la API: $json');

        // Asegurarse de que el campo 'servicios' sea una lista
        if (json.containsKey('servicios') && json['servicios'] is List) {
          final List<dynamic> data = json['servicios'];
          print('Servicios obtenidos: $data');

          setState(() {
            // Guardar servicios en la lista
            _servicios = data;
            _events = {
              for (var servicio in data)
                DateTime.parse(servicio['created_at']): [servicio['descripcion']]
            };
          });
        } else {
          print('La respuesta de la API no contiene una lista de servicios válida.');
        }
      } else {
        print('Error al obtener los servicios: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
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

          // Mostrar servicios obtenidos de la API
          _buildServicesList(),

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
        onPressed: _addNewAppointment,
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

// Método para construir la lista de servicios
Widget _buildServicesList() {
  if (_servicios.isEmpty) {
    return Center(child: Text("Cargando servicios..."));
  }

  return Column(
    children: _servicios.map((servicio) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Icon(Icons.pets, size: 40, color: Colors.lightGreen),
          title: Text(servicio['tipo_de_servicio'], style: TextStyle(fontSize: 20)),
          subtitle: Text("Precio: \$${servicio['precio']}\nDescripción: ${servicio['descripcion']}"),
trailing: ElevatedButton(
  onPressed: () {
    // Navegar a la pantalla de selección de horarios con el callback onHorarioSeleccionado
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HorarioScreen(
          servicio: servicio,
          onHorarioSeleccionado: (horario) {
            // Al seleccionar un horario, se crea una nueva cita
            setState(() {
              DateTime selectedDate = DateTime.parse(horario.split(" ")[0]); // Extrae la fecha del horario

              // Si no hay citas para la fecha seleccionada, se inicializa la lista
              if (_events[selectedDate] == null) {
                _events[selectedDate] = [];
              }
              
              // Agrega el horario seleccionado a la lista de eventos de esa fecha
              _events[selectedDate]!.add('${servicio['tipo_de_servicio']} - ${servicio['descripcion']} a las ${horario.split(" ")[1]}');
              
              // Actualiza los detalles de la cita para la fecha seleccionada
              _specialistDetails = _events[_selectedDate]?.join('\n') ?? 'No hay citas para esta fecha';
            });

            // Mostrar mensaje de confirmación
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cita creada para el ${horario}'))
            );
          },
        ),
      ),
    );
  },
  child: Text("Reservar"),
),


        ),
      );
    }).toList(),
  );
}


void _selectService(BuildContext context, dynamic servicio) {
  List<dynamic> serviciosFiltrados = _servicios.where((s) => s['tipo_de_servicio'] == "cuidar").toList();
  
  if (servicio['tipo_de_servicio'] == "Cuidado de mascotas") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CuidadorList(
          servicios: serviciosFiltrados,
          servicioTipo: servicio['tipo_de_servicio'],
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio de ${servicio['tipo_de_servicio']} seleccionado.')));
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
        String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(result['datetime']);
        _events[_selectedDate]!.add('${result['title']} - ${result['description']} a las $formattedDateTime');
        _specialistDetails = _events[_selectedDate]!.join('\n');
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
