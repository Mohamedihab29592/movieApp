import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/enum.dart';
import 'package:movie_app/movie/domain/useCase/get_review_usecase.dart';
import 'package:movie_app/movie/domain/useCase/movie_details_usecase.dart';
import '../../../domain/useCase/get_cast_usecase.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';





class   MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  final MovieCastUseCase movieCastUseCase;
  final MovieReviewUseCase movieReviewUseCase;
  MovieDetailsBloc(this.movieDetailsUseCase,this.movieCastUseCase,this.movieReviewUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetCastEvent>(_getCast);
    on<GetReviewEvent>(_getReview);

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

  FutureOr<void> _getCast(GetCastEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await movieCastUseCase(MovieCastParameter(id: event.id));
    result.fold(
            (l) => emit(
                state.copyWith(castState: RequestState.error, castMessage: l.message)),
            (r) => emit(state.copyWith(castState: RequestState.loaded, cast: r)));
  }

  FutureOr<void> _getReview(GetReviewEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await movieReviewUseCase(MovieReviewParameter(id: event.id));
    result.fold(
            (l) => emit(
            state.copyWith(movieReviewState: RequestState.error, movieReviewMessage: l.message)),
            (r) => emit(state.copyWith(movieReviewState: RequestState.loaded, movieReview: r)));
  }

}
