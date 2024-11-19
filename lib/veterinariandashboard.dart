import 'package:flutter/material.dart';
import 'petlist.dart';
import 'models/pet.dart';
import 'petprofile.dart';
import 'historial_screen.dart';
import 'base.dart';
import 'visitas_screen.dart';
import 'salud_screen.dart';
import 'appointments_screen.dart'; // Pantalla para citas agendadas
import 'digital_prescriptions_screen.dart'; // Pantalla para recetas digitales

class VeterinarianDashboard extends StatelessWidget {
  final Map<DateTime, List<String>> appointments; // Mapa de citas

  // Constructor que recibe el mapa de citas
  VeterinarianDashboard({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Veterinario"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.white, // Fondo blanco para el ícono
            radius: 50,
            child: Icon(
              Icons.medical_services, // Ícono de servicios médicos
              size: 50,
              color: Colors.blueAccent, // Color del ícono
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Rocky Veterinario',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Especialista en Caninos',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildVetOption(context, Icons.calendar_today, "Citas", AppointmentsScreen()), // Pasar citas a AppointmentsScreen
                _buildVetOption(context, Icons.history, "Historial", HistorialScreen()),
                _buildVetOption(context, Icons.medical_services, "Recetas", DigitalPrescriptionsScreen()),
                _buildVetOption(context, Icons.health_and_safety, "Salud", SaludScreen()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
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
  
  Widget _buildVetOption(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.blueAccent),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
