import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/bloc/movies_filter_bloc/movies_filter_bloc.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/model/movie/genre_model.dart';
import 'package:movies_search/view/search_movies_view.dart';
import 'package:movies_search/widgets/common/error_widget.dart';
import 'package:movies_search/widgets/common/loading_widget.dart';
import 'package:movies_search/widgets/movie_item_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final _scrollController = ScrollController();
  late MoviesFilterBloc _moviesFilterBloc;
  FilterModel filters = FilterModel();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    _moviesFilterBloc = context.read<MoviesFilterBloc>();
    _moviesFilterBloc.add(const FetchMovies(page: 1));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TMDB Movies Database',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          // Search Movies Database
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchMoviesView();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _moviesFilterBloc.currentData.clear();
              _moviesFilterBloc.add(const FetchMovies(page: 1));
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              _textEditingController.clear();
              _showFilterBottomSheet();
            },
            icon: const Icon(
              Icons.filter_list_rounded,
              size: 24,
            ),
          ),
        ],
      ),
      body: _MoviesList(scrollController: _scrollController),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      _moviesFilterBloc.add(
        FetchMovies(
          page: _moviesFilterBloc.page + 1,
        ),
      );
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // genre, release year, and rating
              // Add filter options here
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Genre'),
                  FutureBuilder(
                    future: _moviesFilterBloc.getGenres(),
                    builder: (context, s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return StatefulBuilder(builder: (context, setState) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: filters.genre,
                            items: (s.data as GenreModel)
                                .genres
                                .map((genre) => DropdownMenuItem<int>(
                                      value: genre.id,
                                      child: Text(
                                        genre.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                filters.genre = value;
                              });
                            },
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Release Year (greater than or equal to)'),
                  StatefulBuilder(builder: (context, setState) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: filters.year,
                        items: List.generate(
                          30,
                          (index) => DropdownMenuItem<String>(
                            value: (1990 + index).toString(),
                            child: Text(
                              (1990 + index).toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filters.year = value;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rating (greater than)'),
                  StatefulBuilder(builder: (context, setState) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: filters.rating,
                        items: List.generate(
                          10,
                          (index) => DropdownMenuItem<String>(
                            value: (index + 1).toString(),
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filters.rating = value;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _moviesFilterBloc.filters.isEmpty
                      ? const SizedBox()
                      : TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            // clear all filters
                            filters = FilterModel();
                            _moviesFilterBloc.add(const RemoveFilters());
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Clear Filters',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                  TextButton(
                    onPressed: () {
                      _moviesFilterBloc.add(UpdateFilters(filters: filters));
                      Navigator.pop(context);
                    },
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MoviesList extends StatelessWidget {
  const _MoviesList({
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesFilterBloc, MoviesFilterState>(
      builder: (context, state) {
        return switch (state) {
          MoviesFilterInitial() => const SizedBox(),
          MoviesFilterLoading() => const LoadingWidget(),
          MoviesFilterLoaded() => state.movies.isEmpty
              ? const Center(
                  child: Text("No movies found"),
                )
              : GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieItem(
                      movie: movie,
                      direction: Axis.vertical,
                    );
                  },
                  itemCount: state.movies.length,
                ),
          MoviesFilterError() => const ErrorFetchingDataWidget(),
        };
      },
    );
  }
}
