import 'package:flutter/material.dart';

class OwnerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mascotas"),
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
        children: [
          _buildPetCard("Rocky", "assets/husky.png"),
          _buildPetCard("Bella", "assets/cat.png"),
          _buildPetCard("Blanquito", "assets/rabbit.png"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }

  Widget _buildPetCard(String name, String imagePath) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(imagePath),
        title: Text(name, style: TextStyle(fontSize: 20)),
        onTap: () {
          // Acción al hacer clic en la mascota
        },
      ),
    );
  }
}
