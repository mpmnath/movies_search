part of 'movies_search_bloc.dart';

sealed class MoviesSearchEvent extends Equatable {
  const MoviesSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MoviesSearchEvent {
  const FetchMovies({
    required this.query,
    required this.page,
  });

  final String query;
  //final List<Map<String, dynamic>> filters;
  final int page;

  @override
  List<Object> get props => [query, page];

  @override
  String toString() => 'FetchMovies { query: $query, page: $page}';
}
