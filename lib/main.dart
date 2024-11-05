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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Ruta inicial es la de inicio de sesión
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/userSelection': (context) => UserSelectionPage(),
        '/owner': (context) => OwnerDashboard(),
        '/veterinarian': (context) => VeterinarianDashboard(),
        '/walker': (context) => WalkerDashboard(),
        '/caretaker': (context) => CaretakerDashboard(),
        '/trainer': (context) => TrainerDashboard(),
        '/admin': (context) => AdminDashboard(),
        '/map': (context) => MapScreen(),
        

      },
    );
  }
}
