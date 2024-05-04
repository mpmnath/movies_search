part of 'movies_filter_bloc.dart';

sealed class MoviesFilterState extends Equatable {
  const MoviesFilterState();

  @override
  List<Object> get props => [];
}

final class MoviesFilterInitial extends MoviesFilterState {
  const MoviesFilterInitial();
}

final class MoviesFilterLoading extends MoviesFilterState {
  const MoviesFilterLoading();
}

final class MoviesFilterLoaded extends MoviesFilterState {
  final List<MoviesQueryModel> movies;

  const MoviesFilterLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MoviesFilterError extends MoviesFilterState {
  final String message;

  const MoviesFilterError({required this.message});

  @override
  List<Object> get props => [message];
}
