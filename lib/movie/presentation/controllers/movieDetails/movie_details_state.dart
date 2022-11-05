
 import 'package:equatable/equatable.dart';

import '../../../../core/utilies/appStrings.dart';
import '../../../../core/utilies/enum.dart';
import '../../../domain/entities/movies_detail.dart';
import '../../../domain/entities/recommendation.dart';

class MovieDetailsState extends Equatable {
  final MovieDetails? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;

  final List<Recommendation> movieRecommendation;
  final RequestState movieRecommendationState;
  final String movieRecommendationMessage;


 const MovieDetailsState({
   this.movieDetails,
     this.movieDetailsState = RequestState.loading,
     this.movieDetailsMessage=AppStrings.noData,

   this.movieRecommendation= const[],
   this.movieRecommendationState = RequestState.loading,
   this.movieRecommendationMessage=AppStrings.noData,

 });

  MovieDetailsState copyWith({
    final MovieDetails? movieDetails,
    final RequestState? movieDetailsState,
    final String? movieDetailsMessage,

    final List<Recommendation>? movieRecommendation,
    final RequestState? movieRecommendationState,
    final String? movieRecommendationMessage,
 })
{
  return  MovieDetailsState(
    movieDetails: movieDetails??this.movieDetails,
    movieDetailsState: movieDetailsState ?? this.movieDetailsState,
    movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,

    movieRecommendation: movieRecommendation??this.movieRecommendation,
    movieRecommendationState: movieRecommendationState ?? this.movieRecommendationState,
    movieRecommendationMessage: movieRecommendationMessage ?? this.movieRecommendationMessage,

  );
}

@override
  List<Object?> get props => [movieDetails,movieDetailsState,movieDetailsMessage,movieRecommendation,movieRecommendationState,movieRecommendationMessage];
}


