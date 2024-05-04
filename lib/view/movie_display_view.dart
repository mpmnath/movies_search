import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_search/bloc/movie_bloc/movie_bloc.dart';
import 'package:movies_search/model/movie/movie_model.dart';
import 'package:movies_search/widgets/custom_sliver_appbar_widget.dart';
import 'package:movies_search/widgets/movie/movie_details_widget.dart';

class MovieDisplayView extends StatefulWidget {
  const MovieDisplayView({super.key, required this.id});
  final int id;

  @override
  State<MovieDisplayView> createState() => _MovieDisplayViewState();
}

class _MovieDisplayViewState extends State<MovieDisplayView> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchMovieDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return switch (state) {
          MovieInitial() => const MovieDetailsScaffold(child: SizedBox()),
          MovieLoading() =>
            const MovieDetailsScaffold(child: CircularProgressIndicator()),
          MovieLoaded() => state.movie.id == 0
              ? const MovieDetailsScaffold(child: Text("No movie found"))
              : MovieDataView(movie: state.movie),
          MovieError() => MovieDetailsScaffold(child: Text(state.message)),
        };
      },
    );
  }
}

class MovieDetailsScaffold extends StatelessWidget {
  const MovieDetailsScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Details',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Center(child: child),
    );
  }
}

class MovieDataView extends StatelessWidget {
  const MovieDataView({super.key, required this.movie});

  final MovieModel movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverAppBar(
                expandedHeight: 200.0,
                backdropPath: movie.backdropPath ?? '',
                posterPath: movie.posterPath ?? '',
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100.0,
              ),
            ),
            SliverToBoxAdapter(
              child: MovieDetails(movie: movie),
            )
          ],
        ),
      ),
    );
  }
}
