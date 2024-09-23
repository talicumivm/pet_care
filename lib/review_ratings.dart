import 'package:flutter/material.dart';

class ReviewRatings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comentarios y Valoraciones"),
      ),
      body: Center(
        child: Text("Aquí puedes revisar los comentarios y valoraciones de los servicios."),
      ),
    );
  }
}
