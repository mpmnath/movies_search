part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {
  const MovieInitial();
}

final class MovieLoading extends MovieState {
  const MovieLoading();
}

final class MovieLoaded extends MovieState {
  final MovieModel movie;

  const MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

final class MovieError extends MovieState {
  final String message;

  const MovieError({required this.message});

  @override
  List<Object> get props => [message];
}
