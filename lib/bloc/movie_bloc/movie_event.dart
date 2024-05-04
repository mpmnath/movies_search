part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetails extends MovieEvent {
  const FetchMovieDetails({required this.id});

  final int id;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'FetchMovieDetails { id: $id }';
}
