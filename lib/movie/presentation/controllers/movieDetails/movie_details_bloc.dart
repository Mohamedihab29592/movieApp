import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/enum.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieRecommendation_useCase.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';





class   MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  final RecommendationUseCase recommendationUseCase;
  MovieDetailsBloc(this.movieDetailsUseCase, this.recommendationUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getMovieRecom);
  }



  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await movieDetailsUseCase(MovieDetailsParameter(id: event.id));

    result.fold(
        (l) => emit(state.copyWith(
            movieDetailsState: RequestState.error, movieDetailsMessage: l.message)),
        (r) => emit(state.copyWith(
              movieDetails: r,
              movieDetailsState: RequestState.loaded,
            )));
  }

  FutureOr<void>_getMovieRecom(
      GetMovieRecommendationEvent event , Emitter<MovieDetailsState> emit
      )async {
    final result =
    await recommendationUseCase(MovieRecoParameter(id: event.id));
    result.fold(
            (l) => emit(state.copyWith(
            movieRecommendationState: RequestState.error, movieRecommendationMessage: l.message)),
            (r) => emit(state.copyWith(
          movieRecommendation: r,
          movieRecommendationState: RequestState.loaded,
        )));
  }
}
