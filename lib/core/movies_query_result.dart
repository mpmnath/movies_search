// MoviesQueryResult class to represent the result of the API call
import 'package:movies_search/model/movies_query_model.dart';

class MoviesQueryResult {
  final List<MoviesQueryModel> movies;

  MoviesQueryResult({
    required this.movies,
  });

  @override
  String toString() {
    return 'MoviesQueryResult{movies: $movies}';
  }

// creates a MoviesQueryResult instance from a JSON object
  factory MoviesQueryResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> hits = json['results'] ?? [];

    List<MoviesQueryModel> movies =
        hits.map((movie) => MoviesQueryModel.fromJson(movie)).toList();
    return MoviesQueryResult(
      movies: movies,
    );
  }
}
