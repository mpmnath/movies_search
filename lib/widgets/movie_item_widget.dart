import 'package:flutter/material.dart';
import 'package:movies_search/model/movies_query_model.dart';
import 'package:movies_search/view/movie_display_view.dart';
import 'package:movies_search/widgets/movie/rating_widget.dart';

class MovieItem extends StatelessWidget {
  const MovieItem(
      {super.key, required this.movie, this.direction = Axis.vertical});

  final MoviesQueryModel movie;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MovieDisplayView(
                id: movie.id ?? 0,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (direction == Axis.vertical) ...[
              movie.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_not_supported),
              const SizedBox(height: 4),
            ],
            if (direction == Axis.horizontal) ...[
              movie.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox(width: 50, height: 50),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                movie.title ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (direction == Axis.horizontal) ...[
              const SizedBox(width: 20),
              Rating(rating: movie.voteAverage ?? 0),
            ],
          ],
        ),
      ),
    );
  }
}
