import 'package:flutter/material.dart';

import '../models/models.dart';

/* Convertimos a stateful para redibujar el listviewbuilder y 
conseguir un infinite scroll en la peliculas trending */
class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key, required this.movies, this.title, required this.onNextPage});

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            /* Se envuelve el listView, ya que necesita un tamaño fijo, 
            ya que su padre sería el column y este es flexible, 
            por lo que no se lo puede proporcionar */
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, index) => _MoviePoster(
                    movie: widget.movies[index],
                    heroId:
                        '${widget.title}-${index}-${widget.movies[index].id}')),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key, required this.movie, required this.heroId});

  final Movie movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      /*   color: const Color.fromARGB(255, 30, 201, 192),
      color para ver cuanto ocupa y poder cuadrar */
      margin: const EdgeInsetsDirectional.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          //También podemos añadir padding al elemento superior o inferior
          Text(
            movie.title,
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
