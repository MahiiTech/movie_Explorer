// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// // Movie Model
// class Movie {
//   final String title;
//   final String releaseDate;
//   final String posterUrl;
//
//   Movie({required this.title, required this.releaseDate, required this.posterUrl});
// }
//
// // Movie Bloc Events
// abstract class MovieEvent {}
//
// class SearchMovies extends MovieEvent {
//   final String query;
//   SearchMovies(this.query);
// }
//
// // Movie Bloc State
// abstract class MovieState {}
//
// class MovieInitial extends MovieState {}
//
// class MovieLoaded extends MovieState {
//   final List<Movie> movies;
//   MovieLoaded(this.movies);
// }
//
// // Movie Bloc
// class MovieBloc extends Bloc<MovieEvent, MovieState> {
//   final List<Movie> allMovies = [
//     Movie(
//       title: 'Interstellar',
//       releaseDate: '2014-11-07',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
//     ),
//     Movie(
//       title: 'Avatar',
//       releaseDate: '2009-12-18',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg',
//     ),
//     Movie(
//       title: 'The Matrix',
//       releaseDate: '1999-03-31',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
//     ),
//     Movie(
//       title: 'Avengers: Endgame',
//       releaseDate: '2019-04-26',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
//     ),
//     Movie(
//       title: 'Joker',
//       releaseDate: '2019-10-04',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
//     ),
//     Movie(
//       title: 'Interstellar',
//       releaseDate: '2014-11-07',
//       posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
//     ),
//   ];
//
//
//   MovieBloc() : super(MovieLoaded([])) {
//     on<SearchMovies>((event, emit) {
//       final filteredMovies = event.query.isEmpty
//           ? allMovies
//           : allMovies
//           .where((movie) => movie.title.toLowerCase().contains(event.query.toLowerCase()))
//           .toList();
//       emit(MovieLoaded(filteredMovies));
//     });
//   }
// }
//
// // Movie Screen
// class MovieScreen extends StatelessWidget {
//   final String defaultImage =
//       'https://via.placeholder.com/200x300.png?text=No+Image+Available';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Movies List')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search movies...',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (query) {
//                 context.read<MovieBloc>().add(SearchMovies(query));
//               },
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<MovieBloc, MovieState>(
//               builder: (context, state) {
//                 if (state is MovieLoaded) {
//                   if (state.movies.isEmpty) {
//                     return Center(child: Text('No movies found'));
//                   }
//                   return GridView.builder(
//                     padding: const EdgeInsets.all(8.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // 2 movies per row
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                       childAspectRatio: 0.7, // Adjust height to width ratio
//                     ),
//                     itemCount: state.movies.length,
//                     itemBuilder: (context, index) {
//                       final movie = state.movies[index];
//                       return Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         elevation: 4,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                               child: Image.network(
//                                 movie.posterUrl,
//                                 width: double.infinity,
//                                 height: 165,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Icon(Icons.file_copy_outlined,size: 150,);
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     movie.title,
//                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     movie.releaseDate,
//                                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(
//     BlocProvider(
//       create: (context) => MovieBloc()..add(SearchMovies('')),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: MovieScreen(),
//       ),
//     ),
//   );
// }

// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/bloc/movie_bloc.dart';
import 'package:movie_explorer/bloc/movie_event.dart';
import 'views/movie_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => MovieBloc()..add(SearchMovies('')),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MovieScreen(),
      ),
    ),
  );
}