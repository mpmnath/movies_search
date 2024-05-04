import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movies_query_model.dart';
import 'package:movies_search/repository/movies_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movies_search_event.dart';
part 'movies_search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

// Bloc to manage the movies search
class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final MoviesRepository moviesRepository;
  int page = 1;

  MoviesSearchBloc({required this.moviesRepository})
      : super(const MoviesInitial()) {
    on<FetchMovies>(_onFetchMovies, transformer: debounce(_duration));
  }

  Future<void> _onFetchMovies(
    FetchMovies event,
    Emitter<MoviesSearchState> emit,
  ) async {
    try {
      final movies = await moviesRepository.search(
        event.query,
        FilterModel(),
        page,
      );
      emit(MoviesLoaded(movies.movies));
      page++;
    } catch (e) {
      emit(const MoviesError());
    }
  }
}
