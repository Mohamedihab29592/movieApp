import 'package:movie_app/movie/data/models/geners_model.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.backdropPath,
    required super.id,
    required super.overView,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage,
    required super.genres,
    required super.voteCount,
    required super.status,
    required super.posterPath,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      status: json["status"],
      voteCount: json["vote_count"],
      posterPath: json["poster_path"] ?? json["backdrop_path"] ??'',
      backdropPath: json["backdrop_path"] ?? json["poster_path"]??'',
      id: json["id"],
      overView: json["overview"],
      releaseDate: json["release_date"],
      runtime: json["runtime"],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
      genres: List<GenresModel>.from(
          json["genres"].map((x) => GenresModel.fromJson(x))),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "vote_count": voteCount,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "id": id,
      "overview": overView,
      "release_date": releaseDate,
      "runtime": runtime,
      "title": title,
      "vote_average": voteAverage,
      "genres": genres.map((genre) => (genre as GenresModel).toJson()).toList(),
    };
  }
}