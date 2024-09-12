import 'package:flutter/material.dart';
import '../models/cuidador.dart';

class CuidadorProfile extends StatelessWidget {
  final Cuidador cuidador;

  CuidadorProfile({required this.cuidador});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cuidador.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(cuidador.imagePath, height: 200, width: 200),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre: ${cuidador.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Tipo: ${cuidador.type}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Servicios: ${cuidador.servicios}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 24),
                SizedBox(width: 5),
                Text(
                  '${cuidador.rating}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
