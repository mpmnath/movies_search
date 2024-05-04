import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_search/bloc/movie_bloc/movie_bloc.dart';
import 'package:movies_search/bloc/movies_filter_bloc/movies_filter_bloc.dart';
import 'package:movies_search/bloc/movies_search_bloc/movies_search_bloc.dart';
import 'package:movies_search/core/movies_search_client.dart';
import 'package:movies_search/repository/movies_repository.dart';
import 'package:movies_search/view/movies_list_screen.dart';

void main() {
  final getIt = GetIt.instance;
  // Register the ProductsRepository singleton
  getIt.registerSingleton<MoviesRepository>(
    MoviesRepository(client: MoviesSearchClient()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesFilterBloc>(
          create: (context) => MoviesFilterBloc(
            moviesRepository: GetIt.instance<MoviesRepository>(),
          ),
        ),
        BlocProvider<MoviesSearchBloc>(
          create: (context) => MoviesSearchBloc(
            moviesRepository: GetIt.instance<MoviesRepository>(),
          ),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(
            moviesRepository: GetIt.instance<MoviesRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Movies Search',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviesListScreen(),
      ),
    );
  }
}
