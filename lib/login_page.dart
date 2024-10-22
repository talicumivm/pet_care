import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String connectionMessage = "Conectando..."; // Mensaje inicial
  List<dynamic> _users = [];  // Lista para almacenar los datos recibidos

  @override
  void initState() {
    super.initState();
    _checkConnection();  // Chequea la conexión al cargar la pantalla
    _fetchUsers();  // Obtiene los usuarios desde el backend
  }

  // Función para verificar la conexión con el servidor
  Future<void> _checkConnection() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/test');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          connectionMessage = data['message'];  // Muestra el mensaje de éxito
        });
      } else {
        setState(() {
          connectionMessage = "Error en la conexión: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        connectionMessage = "Error: $e";
      });
    }
  }

  // Función para obtener los usuarios desde la API
  Future<void> _fetchUsers() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/users');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _users = data['users'];  // Almacenar la lista de usuarios
        });
        print('Usuarios obtenidos: $_users');  // Imprime la lista de usuarios en la terminal
      } else {
        print('Error al obtener los usuarios: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Muestra el mensaje de conexión
            Text(connectionMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,  // Llama a la función de login
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navega a la pantalla de registro
              },
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }

  // Función de login que valida solo el correo
  Future<void> _login() async {
    final email = _emailController.text;
    // final password = _passwordController.text; // Comentamos la contraseña por ahora

    if (email.isNotEmpty) {
      // Verifica si existe un usuario con el correo ingresado
      final matchingUser = _users.firstWhere(
        (user) => user['email'] == email,
        orElse: () => null,
      );

      if (matchingUser != null) {
        // Si el correo existe, redirige a la pantalla principal
        print('Inicio de sesión exitoso: ${matchingUser['name']} (${matchingUser['email']})');
        Navigator.pushReplacementNamed(context, '/veterinarian');  // Redirige a la pantalla principal

        /*
        // Si deseas verificar la contraseña, puedes descomentar esta sección más adelante
        if (matchingUser['password'] == password) {
          // Credenciales válidas
          print('Inicio de sesión exitoso: ${matchingUser['name']} (${matchingUser['email']})');
          Navigator.pushReplacementNamed(context, '/veterinarian');  // Redirige a la pantalla principal
        } else {
          // Contraseña incorrecta
          print('Contraseña incorrecta');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
        */

      } else {
        // Correo no encontrado
        print('Correo no encontrado');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correo no encontrado')),
        );
      }
    } else {
      print('Por favor, completa el campo de correo');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa el campo de correo')),
      );
    }
  }
}
