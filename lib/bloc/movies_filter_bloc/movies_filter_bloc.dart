import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movie/genre_model.dart';
import 'package:movies_search/model/movies_query_model.dart';
import 'package:movies_search/repository/movies_repository.dart';

part 'movies_filter_event.dart';
part 'movies_filter_state.dart';

class MoviesFilterBloc extends Bloc<MoviesFilterEvent, MoviesFilterState> {
  final MoviesRepository moviesRepository;

  MoviesFilterBloc({required this.moviesRepository})
      : super(const MoviesFilterInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<UpdateFilters>(_onUpdateFilters);
    on<RemoveFilters>(_onRemoveFilters);
  }

  List<MoviesQueryModel> currentData = []; // Track existing data
  int page = 1;
  FilterModel filters = FilterModel();

  Future<void> _onFetchMovies(
    FetchMovies event,
    Emitter<MoviesFilterState> emit,
  ) async {
    try {
      final movies = await moviesRepository.search(
        '',
        filters,
        page,
      );
      currentData.addAll(movies.movies); // Add new data to existing data
      emit(MoviesFilterLoaded(List.from(currentData)));
      page++;
    } catch (e) {
      emit(MoviesFilterError(message: e.toString()));
    }
  }

  Future<GenreModel> getGenres() async {
    return await moviesRepository.getGenres();
  }

  void _onUpdateFilters(
    UpdateFilters event,
    Emitter<MoviesFilterState> emit,
  ) {
    filters = event.filters;
    page = 1;
    currentData.clear();
    add(const FetchMovies(page: 1));
  }

  void _onRemoveFilters(
    RemoveFilters event,
    Emitter<MoviesFilterState> emit,
  ) {
    filters = FilterModel();
    page = 1;
    currentData.clear();
    add(const FetchMovies(page: 1));
  }
}
