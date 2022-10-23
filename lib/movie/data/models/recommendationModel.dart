import 'package:movie_app/movie/domain/entities/recommendation.dart';

class RecommendationsModel extends Recommendation {
  const RecommendationsModel({required super.id, super.posterPath,super.backdropPath});

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        id: json["id"],
        backdropPath:json["backdrop_path"],
        posterPath:
            json["poster_path"] ,
      );
}
