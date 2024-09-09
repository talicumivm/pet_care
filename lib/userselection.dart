import 'package:flutter/material.dart';

class UserSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tu usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,  // Aumenta el número de columnas para hacer los botones más pequeños
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            _buildUserButton(
              context,
              'Dueño de Mascota',
              Icons.pets,
              Colors.blue,
              '/owner',
            ),
            _buildUserButton(
              context,
              'Veterinario',
              Icons.local_hospital,
              Colors.green,
              '/veterinarian',
            ),
            _buildUserButton(
              context,
              'Paseador',
              Icons.directions_walk,
              Colors.orange,
              '/walker',
            ),
            _buildUserButton(
              context,
              'Cuidador',
              Icons.home,
              Colors.purple,
              '/caretaker',
            ),
            _buildUserButton(
              context,
              'Entrenador',
              Icons.fitness_center,
              Colors.red,
              '/trainer',
            ),
            _buildUserButton(
              context,
              'Administrador',
              Icons.admin_panel_settings,
              Colors.brown,
              '/admin',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserButton(BuildContext context, String label, IconData icon, Color color, String route) {
    return Container(
      width: 100,  // Ajusta el ancho del botón
      height: 100,  // Ajusta la altura del botón
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,  // Cambiado de 'primary' a 'backgroundColor'
          padding: EdgeInsets.all(8),  // Ajusta el padding para un botón más pequeño
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 30.0,  // Reduce el tamaño del icono
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,  // Reduce el tamaño del texto
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
