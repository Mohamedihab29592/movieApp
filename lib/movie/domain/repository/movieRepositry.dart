import 'package:dartz/dartz.dart';
import 'package:movie_app/movie/data/dataSource/remoteDataSource.dart';

import '../../../core/error/faliure.dart';
import '../entities/movie.dart';

abstract class BaseMovieRepository{

  Future<Either<Failure,List<Movie>>> getNowPlaying();
  Future<Either<Failure,List<Movie>>> getPopularPlaying();
  Future<Either<Failure,List<Movie>>> getTopRatedMovie();
}