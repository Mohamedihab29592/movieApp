import 'package:flutter/material.dart';

import '../../controllers/movieDetails/movie_details_state.dart';

class AboutMovieWidget extends StatelessWidget {
  final MovieDetailsState state;

  const AboutMovieWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        state.movieDetails!.overView,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 20,
          height: 1.5,
        ),
      ),
    );
  }
}