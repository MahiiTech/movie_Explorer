// blocs/movie_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/movie_model.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
    final List<Movie> allMovies = [
    Movie(
      title: 'Interstellar',
      releaseDate: '2014-11-07',
      posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    ),
    Movie(
      title: 'Avatar',
      releaseDate: '2009-12-18',
      posterUrl: 'https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg',
    ),
    Movie(
      title: 'The Matrix',
      releaseDate: '1999-03-31',
      posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    ),
    Movie(
      title: 'Avengers: Endgame',
      releaseDate: '2019-04-26',
      posterUrl: 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
    ),
    Movie(
      title: 'Joker',
      releaseDate: '2019-10-04',
      posterUrl: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
    ),
    Movie(
      title: 'Interstellar',
      releaseDate: '2014-11-07',
      posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    ),
  ];

  MovieBloc() : super(MovieLoaded([])) {
    on<SearchMovies>((event, emit) {
      final filteredMovies = event.query.isEmpty
          ? allMovies
          : allMovies.where((movie) => movie.title.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(MovieLoaded(filteredMovies));
    });
  }
}