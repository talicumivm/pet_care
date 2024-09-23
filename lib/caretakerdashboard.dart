import 'package:flutter/material.dart';

class PetActivity {
  String name;
  String status;

  PetActivity({required this.name, this.status = "No comenzado"});

  void updateStatus(String newStatus) {
    status = newStatus;
  }
}

class CaretakerDashboard extends StatefulWidget {
  @override
  _CaretakerDashboardState createState() => _CaretakerDashboardState();
}

class _CaretakerDashboardState extends State<CaretakerDashboard> {
  List<PetActivity> activities = [
    PetActivity(name: "Alimentación"),
    PetActivity(name: "Ejercicio"),
    PetActivity(name: "Agua"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Cuidador"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Registro de Actividades", style: TextStyle(fontSize: 24)),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Card(
                  child: ListTile(
                    leading: _getIconForActivity(activity.name),
                    title: Text(activity.name),
                    subtitle: Text("Estado: ${activity.status}"),
                    trailing: DropdownButton<String>(
                      value: activity.status,
                      items: ["No comenzado", "En proceso", "Terminado"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newStatus) {
                        setState(() {
                          activity.updateStatus(newStatus!);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddActivityDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) {
    String newActivityName = '';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar nueva actividad"),
          content: TextField(
            decoration: InputDecoration(hintText: "Nombre de la actividad"),
            onChanged: (value) {
              newActivityName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (newActivityName.isNotEmpty) {
                  setState(() {
                    activities.add(PetActivity(name: newActivityName));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Agregar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  Icon _getIconForActivity(String name) {
    switch (name) {
      case "Alimentación":
        return Icon(Icons.food_bank, color: Colors.orange);
      case "Ejercicio":
        return Icon(Icons.directions_run, color: Colors.green);
      case "Agua":
        return Icon(Icons.water, color: Colors.blue);
      default:
        return Icon(Icons.help_outline, color: Colors.grey);
    }
  }
}
