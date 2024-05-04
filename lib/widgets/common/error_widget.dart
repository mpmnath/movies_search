import 'package:flutter/material.dart';

class ErrorFetchingDataWidget extends StatelessWidget {
  const ErrorFetchingDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Error fetching data! Please check your internet connection and try again.",
        style: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
      ),
    );
  }
}
