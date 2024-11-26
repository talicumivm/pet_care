import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user_manager.dart';

class HorarioScreen extends StatelessWidget {
  final dynamic servicio;
  final Function(String horario) onHorarioSeleccionado;

  HorarioScreen({required this.servicio, required this.onHorarioSeleccionado});

  Future<List<String>> _fetchCitasOcupadas(int idProveedor) async {
    try {
      var url = Uri.parse('http://127.0.0.1:8000/api/citas/$idProveedor/provider');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> citas = data["citas encontradas"];
        return citas.map((cita) {
          return "${cita['fecha']} ${cita['hora'].substring(0, 5)}";
        }).toList();
      } else {
        print("Error al obtener citas: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error al realizar la petición: $e");
      return [];
    }


  
  }

Future<List<String>> _getHorariosDisponibles(int idProveedor) async {
  List<String> horariosDisponibles = [];
  List<String> citasOcupadas = await _fetchCitasOcupadas(idProveedor);

  // Generar horarios para las próximas dos semanas
  DateTime now = DateTime.now();
  DateTime end = now.add(Duration(days: 14));

  for (DateTime day = now; day.isBefore(end); day = day.add(Duration(days: 1))) {
    DateTime startTime = DateTime(day.year, day.month, day.day, 10, 0);
    DateTime endTime = DateTime(day.year, day.month, day.day, 18, 0);

    for (DateTime time = startTime; time.isBefore(endTime); time = time.add(Duration(minutes: 30))) {
      String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(time);
      if (citasOcupadas.contains(formattedTime)) {
        // Imprimir los horarios que se están omitiendo
        print('Horario omitido porque ya está ocupado: $formattedTime');
      } else {
        horariosDisponibles.add(formattedTime);
      }
    }
  }

  return horariosDisponibles;
}

  Future<void> _enviarCita(BuildContext context, String horario) async {
    try {
      DateTime horarioSeleccionado = DateTime.parse(horario);
      String fecha = DateFormat('yyyy-MM-dd').format(horarioSeleccionado);
      String hora = DateFormat('HH:mm').format(horarioSeleccionado);

      Map<String, dynamic> body = {
        "fecha": fecha,
        "hora": hora,
        "id_mascota": 1,
        "id_servicio": this.servicio['id'],
        "id_proveedor": this.servicio['id_usuario'],
        "id_cliente": UserManager.instance.id
      };

      var url = Uri.parse('http://127.0.0.1:8000/api/citas');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cita creada exitosamente.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear la cita: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar la cita. Intenta de nuevo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar ${servicio['tipo_de_servicio']}'),
      ),
      body: FutureBuilder<List<String>>(
        future: _getHorariosDisponibles(servicio['id_usuario']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar horarios.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay horarios disponibles.'));
          } else {
            List<String> horarios = snapshot.data!;
            return ListView.builder(
              itemCount: horarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Horario: ${horarios[index]}'),
                  onTap: () async {
                    await _enviarCita(context, horarios[index]);
                    onHorarioSeleccionado(horarios[index]);
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
