import 'package:flutter_final_test/domain/treding/treding.dart';
import 'package:flutter_final_test/infrastucture/mappers/movie/movie_mapper.dart';

class TrendingMapper {
  static Trending fromJson(Map<String, dynamic> json) {
    return Trending(
        page: json['page'],
        movies: MovieMapper.fromJsonList(json['results']),
        total_pages: json['total_pages'],
        total_results: json['total_results']);
  }
}
