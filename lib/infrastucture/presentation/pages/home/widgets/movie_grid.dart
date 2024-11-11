import 'package:flutter/material.dart';
import 'package:flutter_final_test/domain/movie/movie.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/home/widgets/movie_card.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return movies.isNotEmpty
        ? Row(
            children: [
              Expanded(
                child: MovieCard(movie: movies[0]),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 48.0,
                  ),
                  child: MovieCard(movie: movies[1]),
                ),
              ),
            ],
          )
        : Container();
  }
}
