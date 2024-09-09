import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trainer Dashboard',
      home: TrainerDashboard(),
    );
  }
} canelon hijo d epya

class TrainerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Entrenador"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Progreso de Entrenamiento",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text(" Sentado"),
              subtitle: Text("Progreso: 90%"),
              trailing: Icon(Icons.arrow_forward), // Agregué un trailing para evitar errores
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Comando: Quieto"),
              subtitle: Text("Progreso: 80%"),
              trailing: Icon(Icons.arrow_forward), // Agregué un trailing para evitar errores
            ),
          ],
        ),
      ),
    );
  }
}