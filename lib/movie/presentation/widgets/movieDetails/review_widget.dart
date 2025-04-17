import 'package:flutter/material.dart';

import '../../../../core/utilies/strings.dart';
import '../../../domain/entities/review.dart';

class ReviewsWidget extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsWidget({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return  const Center(
        child: Text(
          AppStrings.reviewListEmpty,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: reviews.length,
      shrinkWrap: true, // Add this to work inside other scrollable widgets
      physics: const NeverScrollableScrollPhysics(), // Add this if inside a ScrollView
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              review.content,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}