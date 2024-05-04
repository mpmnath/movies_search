// client to fetch data from backend
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:movies_search/core/movie_result.dart';
import 'package:movies_search/core/movies_error.dart';
import 'package:movies_search/core/movies_query_result.dart';
import 'package:http/http.dart' as http;
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movie/genre_model.dart';

class MoviesSearchClient {
  MoviesSearchClient({
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  final http.Client httpClient;

  Future<MoviesQueryResult> search(
    String term,
    FilterModel filter,
    int page,
  ) async {
    String baseUrl = 'https://api.themoviedb.org/3/';
    const String apiKey =
        'api_key=a14a8925ff39d7ec761faf81aa2a07fe'; // hard coded api key, but should be stored in a secure place
    late Response response;

    if (filter.isEmpty && term.isEmpty) {
      baseUrl += 'discover/movie?page=$page&';
      response = await httpClient.get(Uri.parse('$baseUrl$apiKey'));
    } else if (filter.isEmpty) {
      baseUrl += 'search/movie?query=';
      response = await httpClient.get(Uri.parse('$baseUrl$term&$apiKey'));
    } else {
      baseUrl += 'discover/movie?';
      Map<String, dynamic> filterMap = filter.toMap();
      filterMap.removeWhere((key, value) => value == null);
      final movieRequest = Uri.https(
        'api.themoviedb.org',
        '/3/discover/movie',
        {
          'page': page.toString(),
          ...filterMap.map((key, value) => MapEntry(key, value.toString())),
          'api_key': 'a14a8925ff39d7ec761faf81aa2a07fe',
        },
      );
      response = await httpClient.get(movieRequest);
    }

    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MoviesQueryResult.fromJson(results);
    } else {
      throw MovieError.fromJson(results);
    }
  }

  Future<MovieResult> getMovieDetails(int id) async {
    const String baseUrl = 'https://api.themoviedb.org/3/movie/';
    const String apiKey =
        '?api_key=a14a8925ff39d7ec761faf81aa2a07fe'; // hard coded api key, but should be stored in a secure place
    final response = await httpClient.get(Uri.parse('$baseUrl$id$apiKey'));
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MovieResult.fromJson(results);
    } else {
      throw MovieError.fromJson(results);
    }
  }

  Future<MoviesQueryResult> filterMovies(
      List<Map<String, dynamic>> filters) async {
    String baseUrl = 'https://api.themoviedb.org/3/discover/movie?';
    for (final filter in filters) {
      baseUrl += '${filter.keys.first}=${filter.values.first}&';
    }
    const String apiKey =
        '&api_key=a14a8925ff39d7ec761faf81aa2a07fe'; // hard coded api key, but should be stored in a secure place
    final response = await httpClient.get(Uri.parse('$baseUrl$apiKey'));
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MoviesQueryResult.fromJson(results);
    } else {
      throw MovieError.fromJson(results);
    }
  }

  Future<GenreModel> getGenres() async {
    String genresJsonString = await rootBundle.loadString('assets/genres.json');
    final List<dynamic> genresJson = json.decode(genresJsonString);
    List<Genre> genres = genresJson
        .map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
        .toList();

    return GenreModel(genres: genres);
  }
}
