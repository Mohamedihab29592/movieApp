import 'package:movie_app/movie/data/models/genersModel.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';

class MovieDetailsModel extends MovieDetails{
  const MovieDetailsModel({required super.backdropPath, required super.id, required super.overView, required super.releaseDate, required super.runtime, required super.title, required super.voteAverage, required super.genres});

factory MovieDetailsModel.fromJson (Map<String , dynamic>json) =>
    MovieDetailsModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        overView: json["overview"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        genres:List<GenresModel>.from(json["genres"].map((x)=>GenresModel.fromJson(x))),
    );


}