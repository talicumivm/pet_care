import 'package:flutter/material.dart';

class WalkerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel Paseador"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildPetCard("Rocky", "assets/husky.png"),
                _buildPetCard("Bella", "assets/cat.png"),
              ],
            ),
          ),
          Container(
            height: 300,
            color: Colors.grey[200],
            child: Center(child: Text("Mapa de rutas", style: TextStyle(fontSize: 20))),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Rutas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
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
