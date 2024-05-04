import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/model/movie/movie_model.dart';
import 'package:movies_search/repository/movies_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MoviesRepository moviesRepository;
  MovieBloc({required this.moviesRepository}) : super(const MovieInitial()) {
    on<FetchMovieDetails>(_onFetchMovieDetails);
  }

  Future<void> _onFetchMovieDetails(
    FetchMovieDetails event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieLoading());
    try {
      final result = await moviesRepository.getMovieById(event.id);
      emit(MovieLoaded(result.movie));
    } catch (e) {
      emit(MovieError(message: e.toString()));
    }
  }
}
