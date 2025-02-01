// services/movie_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_explorer/models/movie_model.dart';

class MovieService {
  final String apiUrl = "https://imdb236.p.rapidapi.com/imdb/top250-movies";
  final Map<String, String> headers = {
    "X-RapidAPI-Key": "cf0c7fc897msh4f7ee394f50d9a6p10f9abjsnd3e3754979ae",
    "X-RapidAPI-Host": "imdb236.p.rapidapi.com",
  };

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
