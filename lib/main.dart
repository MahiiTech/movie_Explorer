import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/bloc/movie_bloc.dart';
import 'package:movie_explorer/bloc/movie_event.dart';
import 'package:movie_explorer/data/service/http_service.dart';
import 'package:movie_explorer/repository/movie_repository.dart';
import 'views/movie_screen.dart';

void main() {
  final movieService = MovieService();
  final movieRepository = MovieRepository(movieService: movieService);

  runApp(
    BlocProvider(
      create: (context) => MovieBloc(movieRepository: movieRepository)
        ..add(FetchMovies()),
      child: MovieApp(),
    ),
  );
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      home: MovieScreen(toggleTheme: _toggleTheme),
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.blue, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
        displaySmall: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        titleLarge: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900], titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
        displaySmall: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        headlineSmall: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        titleLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
