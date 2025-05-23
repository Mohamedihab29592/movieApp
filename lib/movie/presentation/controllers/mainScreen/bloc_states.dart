import 'package:equatable/equatable.dart';
import 'package:movie_app/core/utilies/enum.dart';

import '../../../../core/utilies/strings.dart';
import '../../../domain/entities/movie.dart';

class MovieState extends Equatable{
  final List<Movie> trendMovies;
  final RequestState trendState;
  final String trendMessage;

  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;

  final List<Movie> popularMovies;
  final RequestState popularState;
  final String popularMessage;


  final List<Movie> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessage;

  final List<Movie> upComingMovies;
  final RequestState upComingState;
  final String upComingMessage;



  const MovieState({
    this.trendMovies = const [],
    this.trendState= RequestState.loading,
    this.trendMessage=AppStrings.noData,

    this.nowPlayingMovies = const [],
    this.nowPlayingState= RequestState.loading,
    this.nowPlayingMessage=AppStrings.noData,

    this.popularMovies = const [],
    this.popularState= RequestState.loading,
    this.popularMessage='',

    this.topRatedMovies = const [],
    this.topRatedState= RequestState.loading,
    this.topRatedMessage='',

    this.upComingMovies = const [],
    this.upComingState= RequestState.loading,
    this.upComingMessage='',


  });
  MovieState copyWith({
    List<Movie>? trendMovies,
    RequestState? trendState,
    String? trendMessage,

     List<Movie>? nowPlayingMovies,
     RequestState? nowPlayingState,
     String? nowPlayingMessage,

     List<Movie>? popularMovies,
     RequestState? popularState,
     String? popularMessage,

    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessage,

    List<Movie>? upComingMovies,
    RequestState? upComingState,
    String? upComingMessage,


}){
return MovieState(
  trendMovies: trendMovies ?? this.trendMovies,
  trendState: trendState ?? this.trendState,
  trendMessage: trendMessage ?? this.trendMessage,

  nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
  nowPlayingState: nowPlayingState ?? this.nowPlayingState,
  nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,

  popularMovies: popularMovies??this.popularMovies,
  popularState: popularState??this.popularState,
  popularMessage: popularMessage??this.popularMessage,

  topRatedMovies: topRatedMovies??this.topRatedMovies,
  topRatedState: topRatedState??this.topRatedState,
  topRatedMessage: topRatedMessage??this.topRatedMessage,

  upComingMovies: upComingMovies??this.upComingMovies,
  upComingState: upComingState??this.upComingState,
  upComingMessage: upComingMessage??this.upComingMessage,


);
}

  @override
  List<Object?> get props =>[trendMovies,trendMessage,trendState,nowPlayingMovies,nowPlayingState,nowPlayingMessage,popularMovies,popularState,popularMessage,topRatedMovies,topRatedState,topRatedMessage,upComingMovies,upComingState,upComingMessage,];

}