import 'package:flutter/cupertino.dart';
import 'package:peliculas_flutter/models/models.dart';
import 'package:peliculas_flutter/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProviders>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 195,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 25),
          width: double.infinity,
          height: 195,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _CastCard(actor: cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key, required this.actor});

  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.fullProfilePath),
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            //También podemos añadir padding al elemento superior o inferior
            Text(
              actor.name,
              //Coloca '...' cuando no cabe el text
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
