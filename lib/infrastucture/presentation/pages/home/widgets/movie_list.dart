import 'package:flutter/material.dart';
import 'package:flutter_final_test/domain/movie/movie.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/home/widgets/movie_grid.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({super.key, required this.movies});

  List<List<T>> groupIntoPairs<T>(List<T> inputList) {
    List<List<T>> pairs = [];
    for (int i = 0; i < inputList.length; i += 2) {
      if (i + 1 < inputList.length) {
        pairs.add([inputList[i], inputList[i + 1]]);
      } else {
        pairs.add([inputList[i]]);
      }
    }
    return pairs;
  }

  @override
  Widget build(BuildContext context) {
    List<List<Movie>> items = groupIntoPairs(movies);

    return movies.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Column(
              children: items
                  .map((pair) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0.0,
                        ),
                        child: MovieGrid(movies: pair),
                      ))
                  .toList(),
            ),
          )
        : Container();
  }
}
