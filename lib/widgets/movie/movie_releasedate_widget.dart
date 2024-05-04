import 'package:flutter/material.dart';
import 'package:movies_search/utils/date_time_utils.dart';

class MovieReleaseDate extends StatelessWidget {
  const MovieReleaseDate({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateTimeUtils.formatDate(dateTime),
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}
