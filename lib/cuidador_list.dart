import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importa para trabajar con JSON

class CuidadorList extends StatefulWidget {
  @override
  _CuidadorListState createState() => _CuidadorListState();
}

class _CuidadorListState extends State<CuidadorList> {
  List<dynamic> _cuidadores = []; // Lista para almacenar cuidadores

  @override
  void initState() {
    super.initState();
    _fetchCuidadores();  // Llama a la función para obtener cuidadores al iniciar la pantalla
  }

  // Función para obtener cuidadores desde tu backend
  Future<void> _fetchCuidadores() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/cuidadores'); // Cambia la URL de tu API

    try {
      final response = await http.get(url); // Realiza la solicitud GET
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _cuidadores = data['cuidadores']; // Actualiza la lista con los cuidadores obtenidos
        });
      } else {
        print('Error al obtener los cuidadores: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cuidadores'),
      ),
      body: ListView.builder(
        itemCount: _cuidadores.length,
        itemBuilder: (context, index) {
          final cuidador = _cuidadores[index];
          return ListTile(
            title: Text(cuidador['name']),
            subtitle: Text(cuidador['email']),
          );
        },
      ),
    );
  }
}
