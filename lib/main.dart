import 'package:flutter/material.dart';
import 'userselection.dart'; // Importa la pantalla de selección de usuario
import 'login_page.dart'; // Importa la pantalla de inicio de sesión
import 'register_page.dart'; // Importa la pantalla de registro
import 'ownerdashboard.dart'; 
import 'veterinariandashboard.dart';
import 'walkerdashboard.dart';
import 'caretakerdashboard.dart';
import 'trainerdashboard.dart';
import 'admindashboard.dart';
import 'map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Crear un mapa de citas vacío o de prueba para `appointments`
  final Map<DateTime, List<String>> appointments = {
    DateTime.now(): ['Cita de prueba'],
    
  };
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/userSelection': (context) => UserSelectionPage(),
        '/owner': (context) => OwnerDashboard(),
        '/veterinarian': (context) => VeterinarianDashboard(appointments: appointments), // Pasar el mapa de citas aquí
        '/walker': (context) => WalkerDashboard(),
        '/caretaker': (context) => CaretakerDashboard(),
        '/trainer': (context) => TrainerDashboard(),
        '/admin': (context) => AdminDashboard(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
