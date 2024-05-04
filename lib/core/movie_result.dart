// MovieResult class to represent the result of the API call

import 'package:movies_search/model/movie/movie_model.dart';

class MovieResult {
  final MovieModel movie;

  MovieResult({
    required this.movie,
  });

  @override
  String toString() {
    return 'MovieResult{movie: $movie}';
  }

// creates a MovieResult instance from a JSON object
  factory MovieResult.fromJson(Map<String, dynamic> json) {
    MovieModel movie = MovieModel.fromJson(json);
    return MovieResult(
      movie: movie,
    );
  }
}
