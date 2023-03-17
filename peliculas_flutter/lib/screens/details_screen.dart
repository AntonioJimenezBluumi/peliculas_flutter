import 'package:flutter/material.dart';

import 'package:peliculas_flutter/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object movie =
        ModalRoute.of(context)?.settings.arguments ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        //Sólo puede llevar dentro widgets que sean de la familia slivers
        slivers: [
          _CustomAppBar(),
          SliverList(
              delegate:
                  //Permite agregar una lista de widgets normales
                  SliverChildListDelegate([
            _PosterAndTitle(),
            const _OverView(),
            const _OverView(),
            const _OverView(),
            const CasatingCards()
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
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
            padding: const EdgeInsets.only(bottom: 7),
            /* Permite que sea legible el título el título de la película 
            si su imagen tiene fondo blanco */
            color: Colors.black12,
            child: const Text(
              'movie.title',
              style: TextStyle(fontSize: 16),
            )),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.originalTitle',
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 20,
                    color: Color.fromARGB(255, 209, 223, 18),
                  ),
                  Text('movie.voteAverate',
                      style: Theme.of(context).textTheme.labelSmall)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 12, left: 25, right: 25),
      child: Text(
          'Aute velit officia eu quis consectetur nulla laboris ipsum pariatur est fugiat. Et consequat ad et et culpa nulla enim adipisicing anim ea pariatur aliqua. Consectetur excepteur elit fugiat duis qui incididunt proident tempor amet ut do esse. Id magna do nostrud magna. Ex dolor tempor ut voluptate. Est ipsum anim aliqua ut esse quis ex labore dolore. Ea occaecat irure enim deserunt ex reprehenderit.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
