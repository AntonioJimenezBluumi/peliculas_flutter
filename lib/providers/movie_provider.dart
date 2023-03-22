import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter/helpers/debouncer.dart';
import 'package:peliculas_flutter/models/models.dart';
import 'dart:convert';

class MoviesProviders extends ChangeNotifier {
  final String _apiKey = '9fdf820cd6b26812da861505e6f4c59b';
  final String _baseURl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProviders() {
    getOnDisplayMovies();
    getOnPopularMovies();
  }
  //'int page' es obligatorio, entre [] es opcional
  Future<String> _getJsonData(String segmento, [int page = 1]) async {
    final url = Uri.https(_baseURl, segmento,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final body = json.decode(jsonData);
    final nowPlayingResponse = NowPlayingResponse.fromJson(body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
    /*  var url = Uri.https(_baseURl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final body = json.decode(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromJson();
    final Map<String, dynamic> decodedData = json.decode(response.body);
    Con el map, y el jsonDecode, podemos filtrar los datos
    print(nowPlayingResponse.results[4].title);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners(); */
  }

//Aumentamos y enviamos popularpage para conseguir un infinte scroll
  getOnPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final body = json.decode(jsonData);
    final popularResponse = PopularResponse.fromJson(body);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    //Para guardar las imágenes de los actores en memoria
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseURl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final body = json.decode(response.body);
    final searchResponse = SearchResponse.fromJson(body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
