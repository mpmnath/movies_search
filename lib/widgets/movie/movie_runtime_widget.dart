import 'package:flutter/material.dart';

class MovieRuntime extends StatelessWidget {
  const MovieRuntime({super.key, required this.runtime});

  final int runtime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 14),
        const SizedBox(width: 4),
        Text(
          '$runtime min',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
