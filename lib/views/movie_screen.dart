import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/bloc/movie_bloc.dart';
import 'package:movie_explorer/bloc/movie_event.dart';
import 'package:movie_explorer/bloc/movie_state.dart';
import 'package:movie_explorer/widgets/movie_card_widget.dart';

class MovieScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const MovieScreen({super.key, required this.toggleTheme});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieBloc>().add(FetchMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Explorer'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme, // Toggling the theme
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search movies...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black, // Set border color based on the theme
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.blue, // Color when focused (blue in light mode)
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black, // Set enabled border color
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey, // Color when the TextField is disabled
                  ),
                ),
              ),
              onChanged: (query) => context.read<MovieBloc>().add(SearchMovies(query)),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return state.movies.isEmpty
                      ? Center(child: Text('No movies found'))
                      : GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) => MovieCard(movie: state.movies[index]),
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MovieBloc>().add(FetchMovies());
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
