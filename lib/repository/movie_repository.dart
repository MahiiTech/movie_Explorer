// repositories/movie_repository.dart


import 'package:movie_explorer/data/service/http_service.dart';
import 'package:movie_explorer/models/movie_model.dart';

class MovieRepository {
  final MovieService movieService;

  MovieRepository({required this.movieService});

  Future<List<Movie>> getMovies() async {
    try {
      return await movieService.fetchMovies();
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}
