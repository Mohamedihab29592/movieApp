import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int id;
  final String title;
  final String? posterPath;
  final String originalLanguage;
  final String? backdropPath;
  final List<int> genreIds;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;

 const Movie(
      {required this.id,
      required this.title,
      required this.originalLanguage,
      required this.voteCount,
          this.posterPath,
          this.backdropPath,
        required  this.genreIds,
        required  this.overview,
        required  this.voteAverage,
        required  this.releaseDate,});

  @override
  List<Object?> get props =>[voteCount,originalLanguage,
    id,title,posterPath,genreIds,overview,voteAverage,releaseDate,backdropPath
  ];


}