// Repository to manage the movies data
import 'package:movies_search/core/movie_result.dart';
import 'package:movies_search/core/movies_query_result.dart';
import 'package:movies_search/core/movies_search_client.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movie/genre_model.dart';

class MoviesRepository {
  final MoviesSearchClient client;

  MoviesRepository({required this.client});

  Future<MoviesQueryResult> search(
    String term,
    FilterModel filters,
    int page,
  ) async {
    return await client.search(term, filters, page);
  }

  Future<MovieResult> getMovieById(int id) async {
    return await client.getMovieDetails(id);
  }

  Future<GenreModel> getGenres() async {
    return await client.getGenres();
  }
}
