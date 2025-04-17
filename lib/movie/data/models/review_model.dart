
import '../../domain/entities/review.dart';

class MovieReviewModel extends Review {
  const MovieReviewModel(
      {required super.content,});

  factory MovieReviewModel.fromJson(Map<String, dynamic> json) =>
      MovieReviewModel(
        content: json['content'],

      );

}