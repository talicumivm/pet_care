import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'add_appointment_dialog.dart';
import 'cuidador_list.dart';
import 'package:http/http.dart' as http;
import 'horario_screen.dart';
import 'appointments_screen.dart'; // Pantalla de citas agendadas
import 'models/user_manager.dart';

class OwnerDashboard extends StatefulWidget {
  @override
  _OwnerDashboardState createState() => _OwnerDashboardState();
}



class _OwnerDashboardState extends State<OwnerDashboard> {
  DateTime _selectedDate = DateTime.now();
  String _specialistDetails = '';
  late Map<DateTime, List<String>> _events;
  List<dynamic> _mascotas = [];  
  List<dynamic> _servicios = [];  // Lista de servicios obtenidos de la API

  @override
  void initState() {
    super.initState();
    _fetchServicios();
    // _fetchEventos();
     _fetchMascotas();
    _events = {
      DateTime.now().add(Duration(days: 1)): ['Cita con el Dr. Juan Pérez a las 10:00 AM'],
      DateTime.now().add(Duration(days: 2)): ['Entrenamiento con Pedro a las 14:00 PM'],
    };
  }

    // Función para obtener las mascotas desde la API
  Future<void> _fetchMascotas() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/mascotas');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('Respuesta completa de las mascotas: $json');

        if (json.containsKey('mascotitas') && json['mascotitas'] is List) {
          final List<dynamic> data = json['mascotitas'];
          print('Mascotas obtenidas: $data');

          setState(() {
            _mascotas = data;
          });
        } else {
          print('La respuesta de la API no contiene una lista de mascotas válida.');
        }
      } else {
        print('Error al obtener las mascotas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  // Función para obtener los servicios desde la API
  Future<void> _fetchServicios() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/servicios');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('Respuesta completa de la API: $json');

        if (json.containsKey('servicios') && json['servicios'] is List) {
          final List<dynamic> data = json['servicios'];
          print('Servicios obtenidos: $data');

          setState(() {
            _servicios = data;
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
        title: Text("Dueño de Mascotas: ${UserManager.instance.name != null ? UserManager.instance.name : 'no logeado'}"),

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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentsScreen(), // Pasar citas a AppointmentsScreen
                ),
              );
            },
            child: Text("Ver Citas Agendadas"),
          ),
          SizedBox(height: 20),
          Text("Servicios disponibles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildServicesList(),
          SizedBox(height: 30),
                    // Mostrar las mascotas obtenidas
          Text("Mis Mascotas", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildMascotasList(),  // Aquí mostramos las mascotas obtenidas
        
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HorarioScreen(
                      servicio: servicio,
                      onHorarioSeleccionado: (horario) {
                        // _crearCita(servicio, horario);
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
  // Controladores para capturar los datos del formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController razaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  String? especieSeleccionada;

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
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Especie"),
                items: <String>['Perro', 'Gato', 'Pájaro'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  especieSeleccionada = value;
                },
              ),
              TextField(
                controller: razaController,
                decoration: InputDecoration(labelText: "Raza"),
              ),
              TextField(
                controller: pesoController,
                decoration: InputDecoration(labelText: "Peso (kg)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: edadController,
                decoration: InputDecoration(labelText: "Edad"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // Crear el objeto mascota
              Map<String, dynamic> nuevaMascota = {
                "nombre": nombreController.text,
                "especie": especieSeleccionada,
                "raza": razaController.text,
                "peso": pesoController.text,
                "edad": int.tryParse(edadController.text) ?? 0,
                "id_usuario": UserManager.instance.id, // Reemplaza con el ID del usuario logueado
              };

              // Enviar la solicitud POST
              await _crearMascota(nuevaMascota);

              Navigator.pop(context); // Cerrar el diálogo
            },
            child: Text("Guardar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar el diálogo sin guardar
            },
            child: Text("Cancelar"),
          ),
        ],
      );
    },
  );
}

// Método para enviar la solicitud POST
Future<void> _crearMascota(Map<String, dynamic> mascota) async {
  final url = Uri.parse('http://127.0.0.1:8000/api/mascotas');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mascota),
    );

    if (response.statusCode == 201) {
      print('Mascota creada exitosamente: ${response.body}');
      // Mostrar un mensaje de éxito o actualizar la lista de mascotas
    } else {
      print('Error al crear la mascota: ${response.statusCode}');
      print('Respuesta del servidor: ${response.body}');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}
Future<List<dynamic>> fetchMascotas() async {
  final url = Uri.parse('http://127.0.0.1:8000/api/mascotas');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['mascotitas'];
  } else {
    throw Exception('Error al obtener las mascotas');
  }
}

  // Widget para mostrar las mascotas obtenidas de la API
  Widget _buildMascotasList() {
    if (_mascotas.isEmpty) {
      return Center(child: Text("Cargando mascotas..."));
    }

    return Column(
      children: _mascotas.map((mascota) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: Icon(Icons.pets, size: 40, color: Colors.lightGreen),
            title: Text(mascota['nombre'], style: TextStyle(fontSize: 20)),
            subtitle: Text("Especie: ${mascota['especie']}\nRaza: ${mascota['raza']}"),
          ),
        );
      }).toList(),
    );
  }
}
