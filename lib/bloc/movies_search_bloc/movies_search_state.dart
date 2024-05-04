part of 'movies_search_bloc.dart';

sealed class MoviesSearchState extends Equatable {
  const MoviesSearchState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesSearchState {
  const MoviesInitial();
}

final class MoviesLoading extends MoviesSearchState {
  const MoviesLoading();
}

final class MoviesLoaded extends MoviesSearchState {
  final List<MoviesQueryModel> movies;

  const MoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MoviesError extends MoviesSearchState {
  const MoviesError();

  @override
  List<Object> get props => [];
}
