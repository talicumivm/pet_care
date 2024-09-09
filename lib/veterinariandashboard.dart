// lib/screens/veterinarian_dashboard.dart
import 'package:flutter/material.dart';
import 'petlist.dart'; // 
import 'models/pet.dart'; // 
import 'petprofile.dart'; // 





class VeterinarianDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Veterinario"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            backgroundImage: AssetImage('assets/husky.png'),
            radius: 50,
          ),
          SizedBox(height: 10),
          Text('Rocky', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVetOption(context, Icons.medical_services, "Visitas"),
              _buildVetOption(context, Icons.health_and_safety, "Salud"),
              _buildVetOption(context, Icons.history, "Historial"),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
            // Aquí navega a la lista de mascotas
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            // Aquí navega al perfil de una mascota
            backgroundColor: Colors.blueAccent,
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetList(),
              ),
            );
          } else if (index == 1) {
            // Navega a una pantalla de perfil vacío (aquí necesitarás definir un perfil específico)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetProfile(
                  pet: Pet(
                    name: "Nombre de Ejemplo",
                    imagePath: "assets/husky.png",
                    type: "Tipo de Ejemplo",
                    breed: "Raza de Ejemplo",
                    weight: "Peso de Ejemplo",
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildVetOption(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
