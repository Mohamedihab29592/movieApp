import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';

import '../../../core/error/exceptions.dart';
import '../dataSource/remoteDataSource.dart';

class MovieRepository extends BaseMovieRepository{
  final RemoteDataSource remoteDataSource;
   MovieRepository(this.remoteDataSource);
  @override
  Future<Either<Failure,List<Movie>>> getNowPlaying() async{
    final result = await remoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularPlaying()async {
    final result = await remoteDataSource.getPopularPlaying();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovie() async{
    final result = await remoteDataSource.getTopRatedMovie();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}