import 'package:equatable/equatable.dart';
import 'package:movie_app/movie/domain/entities/prodication_company.dart';

import 'genres.dart';

class MovieDetails extends Equatable {
  final String backdropPath;
  final String posterPath;
  final List<Genres> genres;
  final List<ProductionCompany> company;
  final int id;
  final String overView;
  final String releaseDate;
  final int runtime;
  final String title;
  final String status;
  final double voteAverage;
  final bool adult;
  final int budget;
  final int voteCount;
  final int revenue;

  const MovieDetails({
    required this.backdropPath,
    required this.posterPath,
    required this.revenue,
    required this.company,
    required this.id,
    required this.overView,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.status,
    required this.genres,
    required this.adult,
    required this.budget,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    revenue,
    company,
    status,
    backdropPath,
    id,
    overView,
    releaseDate,
    runtime,
    title,
    voteAverage,
    genres,
    adult,
    budget,
    voteCount,
    posterPath
  ];
}

