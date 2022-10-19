import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/useCase/useCase.dart';
import 'package:movie_app/core/utilies/enum.dart';
import 'package:movie_app/movie/domain/useCase/getPopularPlaying_useCase.dart';
import 'package:movie_app/movie/domain/useCase/getTopRated_useCase.dart';
import 'package:movie_app/movie/domain/useCase/nowPlaying_useCase.dart';
import 'package:movie_app/movie/presentation/controllers/blocEvents.dart';
import 'package:movie_app/movie/presentation/controllers/blocStates.dart';

class MovieBloc extends Bloc<MovieEvents, MovieState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularPlayingUseCase getPopularUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;

  MovieBloc(this.getNowPlayingUseCase, this.getPopularUseCase,
      this.getTopRatedUseCase)
      : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(GetNowPlayingMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getNowPlayingUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            nowPlayingState: RequestState.error, nowPlayingMessage: l.message)),
        (r) => emit(state.copyWith(
            nowPlayingMovies: r, nowPlayingState: RequestState.loaded)));
  }

  FutureOr<void> _getPopularMovies(GetPopularMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getPopularUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            popularState: RequestState.error, popularMessage: l.message)),
        (r) => emit(state.copyWith(
              popularMovies: r,
              popularState: RequestState.loaded,
            )));
  }

 FutureOr<void>  _getTopRatedMovies(GetTopRatedMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getTopRatedUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            topRatedState: RequestState.error, topRatedMessage: l.message)),
        (r) => emit(state.copyWith(
              topRatedMovies: r,
              topRatedState: RequestState.loaded,
            )));
  }
}
