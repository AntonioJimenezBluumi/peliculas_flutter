// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';
import 'package:peliculas_flutter/models/models.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

class SearchResponse {
  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
