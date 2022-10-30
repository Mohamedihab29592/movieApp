
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/movie/domain/entities/cast.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';
import 'package:movie_app/movie/domain/entities/recommendation.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';
import 'package:movie_app/movie/domain/useCase/getCastUseCase.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieRecommendation_useCase.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/internetCheck.dart';
import '../dataSource/home_local_data_source.dart';
import '../dataSource/remoteDataSource.dart';

class MovieRepository extends BaseMovieRepository{
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;
  final BaseMovieDataLocalDataSource baseMovieDataLocalDataSource;
  final NetworkInfo networkInfo;

  MovieRepository(this.baseMovieRemoteDataSource, this.baseMovieDataLocalDataSource, this.networkInfo);
  @override
  Future<Either<Failure,List<Movie>>> getNowPlaying() async{
    if (await networkInfo.isConnected){
      try {
        final  result = await baseMovieRemoteDataSource.getNowPlayingMovies();

       await   baseMovieDataLocalDataSource.cachedNowPlayingLocalData(movieModel:result);

          return Right(result);
      }on ServerExceptions catch (failure){
        return Left(ServerFailure(failure.errorMessageModel.statusMessage));
      }
    }else {
      try{
        final localHome = await baseMovieDataLocalDataSource.getNowPlayingLocalData();
        return Right(localHome);
      }
      on LocalExceptions {
        return const Left(DataBaseFailure("No Data"));
      }


    }

  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularPlaying()async {
   if(await networkInfo.isConnected)
     {

       final result = await baseMovieRemoteDataSource.getPopularPlaying();
       await   baseMovieDataLocalDataSource.cachedPopularLocalData(movieModel:result);

       try {
         return Right(result);
       }on ServerExceptions catch (failure){
         return Left(ServerFailure(failure.errorMessageModel.statusMessage));
       }
     }else {
     try{
       final localHome = await baseMovieDataLocalDataSource.getPopularLocalData();
       return Right(localHome);
     }
     on LocalExceptions {
       return const Left(DataBaseFailure("No Data"));
     }


   }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovie() async{
  if(await networkInfo.isConnected)
    {
      final result = await baseMovieRemoteDataSource.getTopRatedMovie();
      await   baseMovieDataLocalDataSource.cachedTopRatedLocalData(movieModel:result);

      try {
        return Right(result);
      }on ServerExceptions catch (failure){
        return Left(ServerFailure(failure.errorMessageModel.statusMessage));
      }
    }else {
    try{
      final localHome = await baseMovieDataLocalDataSource.getTopRatedLocalData();
      return Right(localHome);
    }
    on LocalExceptions {
      return const Left(DataBaseFailure("No Data"));
    }


  }
  }
  @override
  Future<Either<Failure, List<Movie>>> getUpComingMovie() async{
   if(await networkInfo.isConnected)
     {
       final result = await baseMovieRemoteDataSource.getUpComingMovie();
       await   baseMovieDataLocalDataSource.cachedUpComingLocalData(movieModel:result);

       try {
         return Right(result);
       }on ServerExceptions catch (failure){
         return Left(ServerFailure(failure.errorMessageModel.statusMessage));
       }
     }else {
     try{
       final localHome = await baseMovieDataLocalDataSource.getUpComingLocalData();
       return Right(localHome);
     }
     on LocalExceptions {
       return const Left(DataBaseFailure("No Data"));
     }


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

  @override
  Future<Either<Failure, List<Cast>>> getMovieCast(MovieCastParameter parameter) async{
    final result = await baseMovieRemoteDataSource.getMovieCast(parameter);
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }





}