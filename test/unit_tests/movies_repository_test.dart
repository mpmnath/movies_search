import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/core/movie_result.dart';
import 'package:movies_search/core/movies_query_result.dart';
import 'package:movies_search/core/movies_search_client.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movie/genre_model.dart';
import 'package:movies_search/model/movie/movie_model.dart';
import 'package:movies_search/repository/movies_repository.dart';

class MockMoviesSearchClient extends Mock implements MoviesSearchClient {}

void main() {
  MoviesRepository? moviesRepository;
  MockMoviesSearchClient? mockMoviesSearchClient;

  setUp(() {
    mockMoviesSearchClient = MockMoviesSearchClient();
    moviesRepository = MoviesRepository(client: mockMoviesSearchClient!);
  });

  test('search returns expected result', () async {
    const term = 'test';
    final filters = FilterModel();
    const page = 1;
    final expected = MoviesQueryResult(movies: []);

    when(mockMoviesSearchClient!.search(term, filters, page))
        .thenAnswer((_) async => expected);

    final result = await moviesRepository!.search(term, filters, page);

    expect(result, expected);
    verify(mockMoviesSearchClient!.search(term, filters, page)).called(1);
  });

  test('getGenres returns expected result', () async {
    final expected = GenreModel(genres: []);

    when(mockMoviesSearchClient!.getGenres()).thenAnswer((_) async => expected);

    final result = await moviesRepository!.getGenres();

    expect(result, expected);
    verify(mockMoviesSearchClient!.getGenres()).called(1);
  });
}
