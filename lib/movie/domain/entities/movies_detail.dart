import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetails extends Equatable{
final String backdropPath;
final List<Genres> genres;
final int id;
final String overView;
final String releaseDate;
final int runtime;
final String title;
final double voteAverage;


const MovieDetails(
      {required this.backdropPath,
      required this.id,
      required this.overView,
      required this.releaseDate,
    required  this.runtime,
     required this.title,
     required this.voteAverage,
      required this.genres});

  @override
  List<Object?> get props => [backdropPath,id,overView,releaseDate,runtime,title,voteAverage,genres];
}