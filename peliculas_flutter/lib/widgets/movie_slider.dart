import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      width: double.infinity,
      height: 305,
      /*  color: AppTheme.primary,
      color para ver cuanto ocupa y poder cuadrar */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Trending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            /* Se envuelve el listView, ya que necesita un tamaño fijo, 
            ya que su padre sería el column y este es flexible, 
            por lo que no se lo puede proporcionar */
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) => _MoviePoster(),
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //Hemos borrado la key
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      /*   color: const Color.fromARGB(255, 30, 201, 192),
      color para ver cuanto ocupa y poder cuadrar */
      margin: const EdgeInsetsDirectional.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400'),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          //También podemos añadir padding al elemento superior o inferior
          const Text(
            'jdjjdjdjdjjdjdjdjdjjdjdjdjdjdjdjdjdjdj',
            maxLines: 2,
            //Coloca '...' cuando no cabe el text
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
