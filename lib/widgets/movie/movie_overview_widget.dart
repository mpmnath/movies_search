import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({
    super.key,
    required this.overview,
  });

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Text(
      overview,
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}
