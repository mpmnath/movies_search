// MovieError class to handle error response from api
class MovieError implements Exception {
  final String message;

  MovieError({required this.message});

  factory MovieError.fromJson(Map<String, dynamic> json) {
    return MovieError(
      message: json['message'],
    );
  }

  @override
  String toString() {
    return 'MovieError: $message';
  }
}
