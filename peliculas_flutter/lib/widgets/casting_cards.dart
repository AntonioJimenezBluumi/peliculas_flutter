import 'package:flutter/material.dart';
import 'package:peliculas_flutter/themes/app_theme.dart';

class CasatingCards extends StatelessWidget {
  const CasatingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      height: 195,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const _CastCard(),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/150x300'),
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          //También podemos añadir padding al elemento superior o inferior
          const Text(
            'jdjjdjdjdjjdjdjdjdjjdjdjdjdjdjdjdjdjdj',
            //Coloca '...' cuando no cabe el text
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
