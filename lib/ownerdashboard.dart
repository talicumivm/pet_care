import 'package:flutter/material.dart';
import 'cuidador_list.dart';

class OwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dueño de Mascotas"),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Acción para el botón de calendario
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Sección de servicios
          Text("Servicios disponibles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildServiceCard(context, "Cuidado de mascotas", Icons.pets, "Reservar servicio de cuidado"),
          _buildServiceCard(context, "Entrenamiento", Icons.directions_run, "Reservar servicio de entrenamiento"),
          _buildServiceCard(context, "Paseo", Icons.directions_walk, "Reservar servicio de paseo"),
          _buildServiceCard(context, "Veterinario", Icons.local_hospital, "Seleccionar veterinario"),
          
          // Sección de horarios disponibles
          SizedBox(height: 30),
          Text("Horarios de veterinarios", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          _buildScheduleCard("Lunes", "9:00 AM - 5:00 PM", isAvailable: true),
          _buildScheduleCard("Martes", "9:00 AM - 5:00 PM", isAvailable: false),
          _buildScheduleCard("Miércoles", "9:00 AM - 5:00 PM", isAvailable: true),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightGreen, // Color verde para el icono seleccionado
        unselectedItemColor: Colors.green, // Color verde para los iconos no seleccionados
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }

  // Función para crear una tarjeta de servicio con icono
  Widget _buildServiceCard(BuildContext context, String serviceName, IconData icon, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.lightGreen),
        title: Text(serviceName, style: TextStyle(fontSize: 20)),
        subtitle: Text(description),
        onTap: () {
          // Acción para cada servicio (reservar o seleccionar)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio de $serviceName seleccionado.')));
        },
      ),
    );
  }

  // Función para crear una tarjeta de horario de veterinarios
  Widget _buildScheduleCard(String day, String hours, {bool isAvailable = true}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: isAvailable ? Colors.white : Colors.grey[300],
      child: ListTile(
        leading: Icon(isAvailable ? Icons.check_circle : Icons.cancel, color: isAvailable ? Colors.green : Colors.red),
        title: Text(day, style: TextStyle(fontSize: 20)),
        subtitle: Text(hours),
        trailing: isAvailable ? null : Text("No disponible", style: TextStyle(color: Colors.red)),
        onTap: isAvailable
            ? () {
                // Acción cuando el horario está disponible
              }
            : null,
      ),
    );
  }
}
