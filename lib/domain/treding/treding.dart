import 'package:flutter_final_test/domain/movie/movie.dart';

class Trending {
  final List<Movie> movies;
  final int page;
  final int total_pages;
  final int total_results;

  Trending({
    required this.movies,
    required this.page,
    required this.total_pages,
    required this.total_results,
  });
}
