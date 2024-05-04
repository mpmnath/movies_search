import 'package:flutter/material.dart';
import 'package:movies_search/model/movie/genre_model.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key, required this.genres});

  final List<Genre> genres;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Genres',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          genres.map((e) => e.name).join(', '),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
