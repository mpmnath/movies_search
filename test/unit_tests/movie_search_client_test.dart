import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:movies_search/core/movies_search_client.dart';
import 'package:movies_search/model/filter_model.dart';

void main() {
  group('MoviesSearchClient', () {
    late MoviesSearchClient client;

    setUp(() {
      client = MoviesSearchClient(
        httpClient: MockClient((request) async {
          return Response('{"results": []}', 200);
        }),
      );
    });

    test('search with empty term and filter', () async {
      final result = await client.search('', FilterModel(), 1);
      expect(result.movies, isEmpty);
    });

    test('search with term and empty filter', () async {
      final result = await client.search('term', FilterModel(), 1);
      expect(result.movies, isEmpty);
    });

    test('search with term and filter', () async {
      final result = await client.search('term', FilterModel(year: "2020"), 1);
      expect(result.movies, isEmpty);
    });
  });
}
