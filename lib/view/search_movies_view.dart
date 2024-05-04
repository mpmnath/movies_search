import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/bloc/movies_search_bloc/movies_search_bloc.dart';
import 'package:movies_search/model/filter_model.dart';
import 'package:movies_search/widgets/common/error_widget.dart';
import 'package:movies_search/widgets/movie_item_widget.dart';

class SearchMoviesView extends StatelessWidget {
  const SearchMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _SearchBar(),
      ),
      body: const _MoviesList(),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textEditingController = TextEditingController();
  late MoviesSearchBloc _moviesSearchBloc;
  FilterModel filters = FilterModel();
  @override
  void initState() {
    super.initState();
    _moviesSearchBloc = context.read<MoviesSearchBloc>();
  }

  void _onClearTapped() {
    _textEditingController.clear();
    _moviesSearchBloc.add(
      const FetchMovies(query: '', page: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _textEditingController,
            onChanged: (query) {
              _moviesSearchBloc.add(
                FetchMovies(query: query, page: 1),
              );
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: _onClearTapped,
                child: const Icon(Icons.clear),
              ),
              border: InputBorder.none,
              hintText: 'Enter a search term',
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviesList extends StatelessWidget {
  const _MoviesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
      builder: (context, state) {
        return switch (state) {
          MoviesInitial() => const SizedBox(),
          MoviesLoading() => const Center(child: CircularProgressIndicator()),
          MoviesLoaded() => state.movies.isEmpty
              ? const Center(
                  child: Text("No movies found"),
                )
              : ListView.builder(
                  itemCount: state.movies.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieItem(
                      movie: movie,
                      direction: Axis.horizontal,
                    );
                  },
                ),
          MoviesError() => const ErrorFetchingDataWidget(),
        };
      },
    );
  }
}
