import 'package:flutter/material.dart';
import 'package:peliculas_flutter/providers/movie_provider.dart';
import 'package:peliculas_flutter/search/search_delegate.dart';
import 'package:peliculas_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('home screen'),
        actions: [IconButton(onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), icon: const Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider de pelíiculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Trending',
              onNextPage: () => moviesProvider.getOnPopularMovies(),
            )
            /* Puedo añadir más y enviarle por parámetros, nombre categoría 
            y sección de la película, estilo netflix o disney */
          ],
        ),
      ),
    );
  }
}
