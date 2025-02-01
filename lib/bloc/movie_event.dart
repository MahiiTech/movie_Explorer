abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;
  SearchMovies(this.query);
}
