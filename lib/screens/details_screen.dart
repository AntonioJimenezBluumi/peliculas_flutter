import 'package:flutter/material.dart';
import 'package:peliculas_flutter/models/models.dart';

import 'package:peliculas_flutter/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        //Sólo puede llevar dentro widgets que sean de la familia slivers
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
              delegate:
                  //Permite agregar una lista de widgets normales
                  SliverChildListDelegate([
            _PosterAndTitle(movie: movie),
            _OverView(movie: movie),
            CastingCards(movieId: movie.id)
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    /* Permite que se oculte el appbar cuando hacemos scroll, 
    además de otros comportamientos */
    return SliverAppBar(
      expandedHeight: 190, //Tamaño del Appbar
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
            //Envolvemos para estilar el título de la película
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 7, left: 15, right: 15),
            /* Permite que sea legible el título el título de la película 
            si su imagen tiene fondo blanco */
            color: Colors.black12,
            child: Text(
              textAlign: TextAlign.center,
              movie.title,
              style: const TextStyle(
                fontSize: 16,
              ),
            )),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          /* Para que la imagen ocupe su espacio disponible 
          sin perder sus dimensiones */
          height: 150,
          fit: BoxFit.cover,
        ),
      ), //Anula que se oculte el appbar
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 15),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Color.fromARGB(255, 209, 223, 18),
                    ),
                    Text('${movie.voteAverage}',
                        style: Theme.of(context).textTheme.labelLarge)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 12, left: 25, right: 25),
      child: Text(movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
