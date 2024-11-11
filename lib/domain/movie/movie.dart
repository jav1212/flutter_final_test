class Movie {
  final bool adult;
  final String backdrop_path;
  final List<dynamic> genre_ids;
  final int id;
  final String original_language;
  final String original_tittle;
  final String overview;
  final double popularity;
  final String poster_path;
  final String release_date;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;

  Movie(
      {required this.adult,
      required this.backdrop_path,
      required this.genre_ids,
      required this.original_language,
      required this.original_tittle,
      required this.overview,
      required this.popularity,
      required this.poster_path,
      required this.release_date,
      required this.title,
      required this.video,
      required this.vote_average,
      required this.vote_count,
      required this.id});
}
