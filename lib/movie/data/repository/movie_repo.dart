
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/movie/domain/entities/cast.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';
import 'package:movie_app/movie/domain/entities/review.dart';
import 'package:movie_app/movie/domain/repository/movie_repositry.dart';
import 'package:movie_app/movie/domain/useCase/get_cast_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_review_usecase.dart';
import 'package:movie_app/movie/domain/useCase/movie_details_usecase.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/internet_check.dart';
import '../../../core/utilies/strings.dart';
import '../../domain/useCase/get_search_usecase.dart';
import '../../domain/useCase/wishlist_usecase.dart';
import '../dataSource/home_local_data_source.dart';
import '../dataSource/remote_data_source.dart';

class MovieRepository extends BaseMovieRepository{
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;
  final BaseMovieDataLocalDataSource baseMovieDataLocalDataSource;
  final NetworkInfo networkInfo;

  MovieRepository(this.baseMovieRemoteDataSource, this.baseMovieDataLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Movie>>> getTrend() async{
    if (await networkInfo.isConnected){
      try {
        final  result = await baseMovieRemoteDataSource.getTrendMovies();

        await   baseMovieDataLocalDataSource.cachedTrendLocalData(movieModel:result);

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
        return const Left(DataBaseFailure(AppStrings.noData));
      }


    }
  }
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
        return const Left(DataBaseFailure(AppStrings.noData));
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
       return const Left(DataBaseFailure(AppStrings.noData));
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
      return const Left(DataBaseFailure(AppStrings.noData));
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
       return const Left(DataBaseFailure(AppStrings.noData));
     }


   }
  }
  @override
  Future<Either<Failure, List<Movie>>> getSearchMovie(MovieSearchParameter parameter)async {
    final result = await baseMovieRemoteDataSource.getSearchMovie(parameter);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
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
  Future<Either<Failure, List<Cast>>> getMovieCast(MovieCastParameter parameter) async{
    final result = await baseMovieRemoteDataSource.getMovieCast(parameter);
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getMovieReview(MovieReviewParameter parameter) async{
    final result = await baseMovieRemoteDataSource.getMovieReview(parameter);
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }  }

  @override
  Future<Either<Failure, List<MovieDetails>>> getWishListMovie() async{
    final result = await baseMovieDataLocalDataSource.getWishLocalData();
    try {
      return Right(result);
    }on ServerExceptions catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }   }

  @override
  Future<Either<Failure, void>> addToWishlist(AddToWishlistParameters parameter) async {
    try {
      final currentWishlist = await baseMovieDataLocalDataSource.getWishLocalData();

      currentWishlist.add(parameter.movie);

      await baseMovieDataLocalDataSource.cachedWishLocalData(movieModel: currentWishlist);

      return const Right(null);
    } on LocalExceptions catch (e) {
      if (e.message == AppStrings.noData) {
        await baseMovieDataLocalDataSource.cachedWishLocalData(
            movieModel: [parameter.movie]
        );
        return const Right(null);
      }
      return Left(DataBaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(RemoveFromWishlistParameters parameter) async {
    try {
      final currentWishlist = await baseMovieDataLocalDataSource.getWishLocalData();

      final updatedWishlist = currentWishlist
          .where((movie) => movie.id != parameter.movieId)
          .toList();

      await baseMovieDataLocalDataSource.cachedWishLocalData(movieModel: updatedWishlist);

      return const Right(null);
    } on LocalExceptions catch (e) {
      return Left(DataBaseFailure(e.message));
    }
  }







}