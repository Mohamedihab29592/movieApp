import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/useCase/use_case.dart';
import 'package:movie_app/core/utilies/enum.dart';
import 'package:movie_app/movie/domain/useCase/get_popular_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_toprated_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_trend_usecase.dart';
import 'package:movie_app/movie/domain/useCase/now_playing_usecase.dart';
import '../../../domain/useCase/up_coming_usecase.dart';
import 'bloc_events.dart';
import 'bloc_states.dart';

class MovieBloc extends Bloc<MovieEvents, MovieState> {

  final GetTrendUseCase getTrendUseCase;
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularPlayingUseCase getPopularUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  final GetUpComingUseCase getUpComingUseCase;


  MovieBloc(this.getTrendUseCase,this.getNowPlayingUseCase, this.getPopularUseCase,
      this.getTopRatedUseCase, this.getUpComingUseCase,)
      : super( const MovieState()) {
    on<GetTrendMoviesEvent>(_getTrendMovies);
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpComingMoviesEvent>(_getUpComingMovies);

  }
  FutureOr<void> _getTrendMovies(GetTrendMoviesEvent event, Emitter<MovieState> emit) async {
    final result = await getTrendUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
                trendState: RequestState.error, trendMessage: l.message)),
            (r) => emit(state.copyWith(
                trendMovies: r, trendState: RequestState.loaded)));
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



