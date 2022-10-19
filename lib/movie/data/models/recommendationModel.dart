import 'package:movie_app/movie/domain/entities/recommendation.dart';

class RecommendationsModel extends Recommendation {
  const RecommendationsModel({required super.id, super.backdropPath});

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        id: json["id"],
        backdropPath:
            json["backdrop_path"] ?? '/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg',
      );
}
