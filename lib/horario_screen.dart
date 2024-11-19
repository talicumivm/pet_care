import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/user_manager.dart';

class HorarioScreen extends StatelessWidget {
  final dynamic servicio;
  final Function(String horario) onHorarioSeleccionado; // Callback para seleccionar horario

  HorarioScreen({required this.servicio, required this.onHorarioSeleccionado});

  Future<void> _enviarCita(String horario) async {
    try {
      // Dividir el horario en fecha y hora
      DateTime horarioSeleccionado = DateTime.parse(horario);
      String fecha = DateFormat('yyyy-MM-dd').format(horarioSeleccionado);
      String hora = DateFormat('HH:mm').format(horarioSeleccionado);

      // Crear el cuerpo de la solicitud
      Map<String, dynamic> body = {
        "fecha": fecha,
        "hora": hora,
        "id_mascota": 1,
        "id_servicio": this.servicio['id'],
        "id_proveedor": this.servicio['id_usuario'],
        "id_cliente": UserManager.instance.id
      };

      print("body enviado ${body}");

      // Realizar la solicitud POST
      var url = Uri.parse('http://127.0.0.1:8000/api/citas');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      // Manejar la respuesta
      if (response.statusCode == 200) {
        print('Cita creada exitosamente: ${response.body}');
      } else {
        print('Error al crear la cita: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error al enviar la cita: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar ${servicio['tipo_de_servicio']}'),
      ),
      body: _buildHorarioList(context),
    );
  }

  Widget _buildHorarioList(BuildContext context) {
    // Generar horarios para las próximas dos semanas
    List<String> horarios = [];
    DateTime now = DateTime.now();
    DateTime end = now.add(Duration(days: 14));

    // Iterar desde las 10:00 AM hasta las 6:00 PM para cada día
    for (DateTime day = now; day.isBefore(end); day = day.add(Duration(days: 1))) {
      DateTime startTime = DateTime(day.year, day.month, day.day, 10, 0);
      DateTime endTime = DateTime(day.year, day.month, day.day, 18, 0);

      for (DateTime time = startTime; time.isBefore(endTime); time = time.add(Duration(minutes: 30))) {
        // Formatear el horario para mostrarlo de forma legible
        String formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(time);
        horarios.add(formattedTime);
      }
    }

    return ListView.builder(
      itemCount: horarios.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Horario: ${horarios[index]}'),
          onTap: () async {
            print('Horario seleccionado: ${horarios[index]} y ${this.servicio['id']}');
            // Enviar la cita al servidor
            await _enviarCita(horarios[index]);
            // Llamar al callback cuando se selecciona un horario
            onHorarioSeleccionado(horarios[index]);
            Navigator.pop(context); // Volver a la pantalla anterior
          },
        );
      },
    );
  }
}
