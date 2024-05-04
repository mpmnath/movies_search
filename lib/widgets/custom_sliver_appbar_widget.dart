import 'package:flutter/material.dart';
import 'package:movies_search/widgets/movie/movie_poster_card_widget.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String backdropPath;
  final String posterPath;
  CustomSliverAppBar({
    required this.expandedHeight,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff8360c3),
                Color(0xff2ebf91),
              ],
            ),
            image: backdropPath != ""
                ? DecorationImage(
                    image: Image.network(
                            "https://image.tmdb.org/t/p/w500$backdropPath")
                        .image,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: const SizedBox(),
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset + 50,
          left: 10,
          child: MoviePosterCard(
            height: expandedHeight,
            width: 150,
            imageUrl: 'https://image.tmdb.org/t/p/original/$posterPath',
          ),
        ),
        // Back Button
        Positioned(
          top: 20,
          left: 5,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
