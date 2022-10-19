import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';
import 'package:movie_app/movie/domain/entities/recommendation.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieRecommendation_useCase.dart';

import '../../../core/error/exceptions.dart';
import '../dataSource/remoteDataSource.dart';

class MovieRepository extends BaseMovieRepository{
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;
   MovieRepository(this.baseMovieRemoteDataSource);
  @override
  Future<Either<Failure,List<Movie>>> getNowPlaying() async{
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularPlaying()async {
    final result = await baseMovieRemoteDataSource.getPopularPlaying();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovie() async{
    final result = await baseMovieRemoteDataSource.getTopRatedMovie();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(MovieDetailsParameter parameter) async{
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameter);
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getMovieRecommendation(MovieRecoParameter parameter) async{
    final result = await baseMovieRemoteDataSource.getMovieRecommendation(parameter);

    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}