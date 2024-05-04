part of 'movies_filter_bloc.dart';

sealed class MoviesFilterEvent extends Equatable {
  const MoviesFilterEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MoviesFilterEvent {
  const FetchMovies({
    required this.page,
  });

  //final List<Map<String, dynamic>> filters;
  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'FetchMovies {page: $page}';
}

class UpdateFilters extends MoviesFilterEvent {
  const UpdateFilters({required this.filters});

  final FilterModel filters;

  @override
  List<Object> get props => [filters];

  @override
  String toString() => 'UpdateFilters { filters: $filters }';
}

class RemoveFilters extends MoviesFilterEvent {
  const RemoveFilters();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'RemoveFilters';
}
