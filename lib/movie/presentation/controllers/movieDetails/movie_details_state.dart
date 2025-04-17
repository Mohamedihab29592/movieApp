
 import 'package:equatable/equatable.dart';
import 'package:movie_app/movie/domain/entities/review.dart';

import '../../../../core/utilies/strings.dart';
import '../../../../core/utilies/enum.dart';
import '../../../domain/entities/cast.dart';
import '../../../domain/entities/movies_detail.dart';

class MovieDetailsState extends Equatable {
  final MovieDetails? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;

  final List<Review> movieReview;
  final RequestState movieReviewState;
  final String movieReviewMessage;


  final List<Cast>? cast;
  final RequestState castState;
  final String castMessage;

 const MovieDetailsState({
   this.movieDetails,
     this.movieDetailsState = RequestState.loading,
     this.movieDetailsMessage=AppStrings.noData,

   this.movieReview= const[],
   this.movieReviewState = RequestState.loading,
   this.movieReviewMessage=AppStrings.noData,

   this.cast,
   this.castState = RequestState.loading,
   this.castMessage=AppStrings.noData,

 });

  MovieDetailsState copyWith({
    final MovieDetails? movieDetails,
    final RequestState? movieDetailsState,
    final String? movieDetailsMessage,

    final List<Review>? movieReview,
    final RequestState? movieReviewState,
    final String? movieReviewMessage,

    final List<Cast>? cast,
    final RequestState? castState,
    final String? castMessage,
 })
{
  return  MovieDetailsState(
    movieDetails: movieDetails??this.movieDetails,
    movieDetailsState: movieDetailsState ?? this.movieDetailsState,
    movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,

    movieReview: movieReview??this.movieReview,
    movieReviewState: movieReviewState ?? this.movieReviewState,
    movieReviewMessage: movieReviewMessage ?? this.movieReviewMessage,

    cast: cast??this.cast,
    castMessage: castMessage ?? this.castMessage,
    castState: castState ?? this.castState,

  );
}

@override
  List<Object?> get props => [movieDetails,movieDetailsState,movieDetailsMessage,movieReview,movieReviewState,movieReviewMessage,cast,castMessage,castState];
}


