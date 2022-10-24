import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/useCase/useCase.dart';
import 'package:movie_app/core/utilies/enum.dart';
import 'package:movie_app/movie/domain/useCase/getPopularPlaying_useCase.dart';
import 'package:movie_app/movie/domain/useCase/getTopRated_useCase.dart';
import 'package:movie_app/movie/domain/useCase/nowPlaying_useCase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/useCase/upComingUseCase.dart';
import 'blocEvents.dart';
import 'blocStates.dart';

class MovieBloc extends Bloc<MovieEvents, MovieState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularPlayingUseCase getPopularUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  final GetUpComingUseCase getUpComingUseCase;

  MovieBloc(this.getNowPlayingUseCase, this.getPopularUseCase,
      this.getTopRatedUseCase, this.getUpComingUseCase)
      : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpComingMoviesEvent>(_getUpComingMovies);
  }

  FutureOr<void> _getNowPlayingMovies(GetNowPlayingMoviesEvent event, Emitter<MovieState> emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();

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

  FutureOr<void>  _getUpComingMovies(GetUpComingMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getUpComingUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            upComingState: RequestState.error, upComingMessage: l.message)),
            (r) => emit(state.copyWith(
          upComingMovies: r,
          upComingState: RequestState.loaded,
        )));
  }

}
