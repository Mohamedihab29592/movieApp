import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetails extends Equatable {
  final String backdropPath;
  final String posterPath;
  final List<Genres> genres;
  final int id;
  final String overView;
  final String releaseDate;
  final int runtime;
  final String title;
  final String status;
  final double voteAverage;
  final int voteCount;

  const MovieDetails({
    required this.backdropPath,
    required this.posterPath,
    required this.id,
    required this.overView,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.status,
    required this.genres,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    status,
    backdropPath,
    id,
    overView,
    releaseDate,
    runtime,
    title,
    voteAverage,
    genres,
    voteCount,
    posterPath
  ];
}

