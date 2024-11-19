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
    print('Ejecutando initState'); 
    // _checkConnection();  // Chequea la conexión al cargar la pantalla
    _fetchUsers();  // Obtiene los usuarios desde el backend
  }

  // // Función para verificar la conexión con el servidor
  // Future<void> _checkConnection() async {
  //   final url = Uri.parse('http://127.0.0.1:8000/api/users');
  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       setState(() {
  //         connectionMessage = data['message'];  // Muestra el mensaje de éxito
  //       });
  //     } else {
  //       setState(() {
  //         connectionMessage = "Error en la conexión: ${response.statusCode}";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       connectionMessage = "Error: $e";
  //     });
  //   }
  // }

  // Función para obtener los usuarios desde la API
  Future<void> _fetchUsers() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/users');
    try {
      final response = await http.get(url);
      
      print('Response status code: ${response.statusCode}');  // Verifica el código de estado
      print('Response body: ${response.body}');  // Muestra el cuerpo de la respuesta

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _users = data['users'];  // Almacenar la lista de usuarios
        });
        print('Usuarios obtenidos: $_users');  // Imprime la lista de usuarios
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

  // Función de login que valida el correo y redirige según el tipo de usuario
// Función de login que valida el correo y contraseña
Future<void> _login() async {
  final email = _emailController.text;
  final password = _passwordController.text;

  if (email.isNotEmpty && password.isNotEmpty) {
    // Crea el cuerpo de la solicitud
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    // Realiza la solicitud POST al backend
    final url = Uri.parse('http://127.0.0.1:8000/api/users/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Obtiene los datos del usuario desde la respuesta
        final user = data['user'];

        // Actualiza el estado del mensaje de conexión
        setState(() {
          connectionMessage = "Inicio de sesión exitoso";  // Mensaje de éxito
        });

        // Guarda los datos del usuario para uso posterior, como el nombre, tipo, etc.
        print('Usuario logueado: ${user['name']} (${user['email']})');

        // Redirige según el rol del usuario
        String role = user['tipo'];

        if (role == 'veterinarian') {
          Navigator.pushReplacementNamed(context, '/veterinarian');
        } else if (role == 'cuidador') {
          Navigator.pushReplacementNamed(context, '/cuidador');
        } else if (role == 'owner') {
          Navigator.pushReplacementNamed(context, '/owner');
        } else {
          print('Rol desconocido: $role');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rol desconocido')),
          );
        }
      } else {
        // Si el estado no es 200, muestra el mensaje de error
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error al iniciar sesión')),
        );
      }
    } catch (e) {
      // Si hay un error de conexión
      print('Error de conexión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión')),
      );
    }
  } else {
    // Si no se ha ingresado correo o contraseña
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, completa todos los campos')),
    );
  }
}
}
