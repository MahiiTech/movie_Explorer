// views/movie_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/bloc/movie_bloc.dart';
import 'package:movie_explorer/bloc/movie_event.dart';
import 'package:movie_explorer/bloc/movie_state.dart';
import 'package:movie_explorer/widgets/movie_card_widget.dart';


class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search movies...', border: OutlineInputBorder()),
              onChanged: (query) => context.read<MovieBloc>().add(SearchMovies(query)),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoaded) {
                  return state.movies.isEmpty
                      ? Center(child: Text('No movies found'))
                      : GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) => MovieCard(movie: state.movies[index]),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
