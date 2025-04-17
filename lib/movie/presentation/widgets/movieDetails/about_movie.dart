import 'package:flutter/material.dart';

import '../../../../core/utilies/strings.dart';
import '../../controllers/movieDetails/movie_details_state.dart';

class AboutMovieWidget extends StatelessWidget {
  final MovieDetailsState state;

  const AboutMovieWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(state.movieReview.isEmpty)
      {
        return  const Center(
          child: Text(
            AppStrings.aboutEmpty,
            style: TextStyle(color: Colors.grey,),
          ),
        );
      }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          state.movieDetails!.overView,
          style: const TextStyle(
            fontSize: 20,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}