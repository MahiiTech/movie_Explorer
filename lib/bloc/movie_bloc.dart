import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repository/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieLoading()) {
    on<FetchMovies>(_onFetchMovies);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(FetchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to load movies'));
    }
  }

  void _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) {
    if (event.query.isEmpty) {
      // When the search query is cleared, fetch all movies again
      add(FetchMovies()); // Trigger the event to reload all movies
    } else {
      // If there's a search query, filter the movies
      if (state is MovieLoaded) {
        final allMovies = (state as MovieLoaded).movies;
        final filteredMovies = allMovies.where((movie) =>
            movie.title.toLowerCase().contains(event.query.toLowerCase())).toList();
        emit(MovieLoaded(filteredMovies));
      }
    }
  }
}
