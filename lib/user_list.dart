import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart'; // Importa la clase User
import 'user_profile.dart'; // Importa la pantalla de perfil de usuario

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> _users = [];  // Lista para almacenar usuarios

  @override
  void initState() {
    super.initState();
    _fetchUsers();  // Llama a la función para obtener usuarios al iniciar la pantalla
  }

  // Función para obtener usuarios desde tu backend
  Future<void> _fetchUsers() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/users');  // Cambia por tu URL de backend

    try {
      final response = await http.get(url);  // Realiza la solicitud GET
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _users = data['users'];  // Actualiza la lista con los usuarios obtenidos
        });
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
        title: Text('Lista de Usuarios'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return _buildUserCard(context, user); // Usa el método para construir la tarjeta
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, dynamic user) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.person, size: 50), // Reemplaza con una imagen si la tienes
        title: Text(user['name'], style: TextStyle(fontSize: 20)),
        subtitle: Text(user['tipo']), // Muestra el rol del usuario
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(user: User(
                  name: user['name'], 
                  imagePath: 'assets/user.png',  // Cambia si tienes imágenes en tu backend
                  email: user['email'], 
                  role: user['tipo']
              )),
            ),
          );
        },
      ),
    );
  }
}
