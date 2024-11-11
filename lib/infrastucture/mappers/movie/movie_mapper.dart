import 'package:flutter_final_test/domain/movie/movie.dart';

class MovieMapper {
  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'],
      backdrop_path: json['backdrop_path'] ?? "",
      genre_ids: json['genre_ids'],
      id: json['id'],
      original_language: json['original_language'],
      original_tittle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      poster_path: json['poster_path'].toString().replaceAll("/", ""),
      release_date: json['release_date'],
      title: json['title'],
      video: json['video'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  static List<Movie> fromJsonList(dynamic jsonList) {
    return jsonList.map<Movie>((json) => fromJson(json)).toList();
  }
}
