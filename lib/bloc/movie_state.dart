// blocs/movie_state.dart
import 'package:movie_explorer/models/movie_model.dart';

abstract class MovieState {}
class MovieInitial extends MovieState {}
class MovieLoaded extends MovieState {
  final List<Movie> movies;
  MovieLoaded(this.movies);
}