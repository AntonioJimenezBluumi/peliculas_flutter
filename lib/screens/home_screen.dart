import 'package:flutter/material.dart';
import 'package:peliculas_flutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home screen'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(),
            //Slider de pelíiculas
            MovieSlider() 
            /* Puedo añadir más y enviarle por parámetros, nombre categoría 
            y sección de la película, estilo netflix o disney */
          ],
        ),
      ),
    );
  }
}
