import 'package:equatable/equatable.dart';

abstract class MovieEvents extends Equatable{
  const MovieEvents();

  @override
  List<Object?> get props => [];
}

class GetTrendMoviesEvent extends MovieEvents{}
class GetNowPlayingMoviesEvent extends MovieEvents{}
class GetPopularMoviesEvent extends MovieEvents{}
class GetTopRatedMoviesEvent extends MovieEvents{}
class GetUpComingMoviesEvent extends MovieEvents{}