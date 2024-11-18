import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importa para trabajar con JSON

class CuidadorList extends StatefulWidget {
  final String servicioTipo; // Recibe el tipo de servicio
  final List<dynamic> servicios; // Lista de servicios pasados desde OwnerDashboard

  CuidadorList({required this.servicioTipo, required this.servicios}); // Constructor para recibir los parámetros

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
        title: Text('Lista de Cuidadores - ${widget.servicioTipo}'),
      ),
      body: _buildCuidadoresList(), // Mostrar la lista de cuidadores
    );
  }

  // Método para construir la lista de cuidadores
  Widget _buildCuidadoresList() {
    if (_cuidadores.isEmpty) {
      return Center(child: CircularProgressIndicator()); // Indicador de carga mientras se obtienen los cuidadores
    }

    return ListView.builder(
      itemCount: _cuidadores.length,
      itemBuilder: (context, index) {
        final cuidador = _cuidadores[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            title: Text(cuidador['name']),
            subtitle: Text(cuidador['email']),
          ),
        );
      },
    );
  }
}
