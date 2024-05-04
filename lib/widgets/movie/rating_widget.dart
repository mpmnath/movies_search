import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          rating.toStringAsPrecision(2).toString(),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.star, color: Colors.yellow),
      ],
    );
  }
}
