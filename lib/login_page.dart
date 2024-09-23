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
              onPressed: _login,
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

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Realiza la petición GET al backend
      final url = Uri.parse('http://127.0.0.1:5000/users'); // Reemplaza con tu URL de backend
      final response = await http.get(url);
      

      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
          
        // Busca si existe un usuario con las credenciales proporcionadas
        
        final matchingUser = users.firstWhere(
          (user) => user['correo'] == email && user['password'] == password,
          orElse: () => null,
        );
               //&& user['password'] == password
       

        //print('la wea de users $email');
        if (matchingUser != null) {
          // Credenciales válidas, redirige a la pantalla principal
          Navigator.pushReplacementNamed(context, '/veterinarian');
        } else {
          // Credenciales inválidas, muestra un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Correo o contraseña incorrectos')),
          );
        }
      } else {
        // Error en la respuesta del servidor
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al contactar con el servidor')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }
}
