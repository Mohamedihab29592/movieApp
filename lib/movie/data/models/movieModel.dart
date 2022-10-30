import 'package:movie_app/movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.id,
      required super.title,
      required super.voteCount,
      required super.originalLanguage,
      required super.posterPath,
      required super.genreIds,
      required super.overview,
      required super.voteAverage,
      required super.releaseDate,
      required super.backdropPath,});


  factory MovieModel.fromJson (Map<String, dynamic>json) => MovieModel(
      id: json["id"],
      title: json["title"],
      voteCount: json["vote_count"],
      originalLanguage: json["original_language"],
      posterPath: json["poster_path"]??json["backdrop_path"],
      backdropPath: json["backdrop_path"]??json["poster_path"],
      genreIds: List<int>.from(json["genre_ids"].map((e)=>e)),
      overview: json["overview"],
      voteAverage: json["vote_average"].toDouble(),
      releaseDate: json["release_date"]
  );
Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "vote_count": voteCount,
      "original_language": originalLanguage,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "genre_ids": genreIds,
      "overview": overview,
      "vote_average": voteAverage,
      "release_date": releaseDate,
    };
  }

}

