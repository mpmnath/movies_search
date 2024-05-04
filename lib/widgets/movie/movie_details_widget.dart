import 'package:flutter/material.dart';
import 'package:movies_search/model/movie/movie_model.dart';
import 'package:movies_search/widgets/movie/movie_genres_widget.dart';
import 'package:movies_search/widgets/movie/movie_overview_widget.dart';
import 'package:movies_search/widgets/movie/movie_releasedate_widget.dart';
import 'package:movies_search/widgets/movie/movie_runtime_widget.dart';
import 'package:movies_search/widgets/movie/movie_title_header_widget.dart';
import 'package:movies_search/widgets/movie/rating_widget.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieTitleHeader(title: movie.title ?? ''),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MovieReleaseDate(dateTime: movie.releaseDate!),
              MovieRuntime(runtime: movie.runtime ?? 0),
              Rating(rating: movie.voteAverage ?? 0.0),
            ],
          ),
          const SizedBox(height: 10),
          MovieOverview(overview: movie.overview ?? ''),
          const SizedBox(height: 10),
          const Divider(),
          // Genres
          MovieGenres(genres: movie.genres),
          const Divider(),

          // Production Companies
          // Production Countries
        ],
      ),
    );
  }
}
