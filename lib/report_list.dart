import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  List<dynamic> _reports = [];  // Lista para almacenar los reportes

  @override
  void initState() {
    super.initState();
    _fetchReports();  // Llama a la función para obtener los reportes al iniciar la pantalla
  }

  // Función para obtener reportes desde tu backend
  Future<void> _fetchReports() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/reports');  // Cambia por tu URL de backend para reportes

    try {
      final response = await http.get(url);  // Realiza la solicitud GET
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _reports = data['reports'];  // Actualiza la lista con los reportes obtenidos
        });
      } else {
        print('Error al obtener los reportes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Reportes'),
      ),
      body: ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          return ListTile(
            title: Text(report['title']),
            subtitle: Text(report['description']),
          );
        },
      ),
    );
  }
}
