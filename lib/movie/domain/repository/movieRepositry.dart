import 'package:dartz/dartz.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';
import 'package:movie_app/movie/domain/entities/recommendation.dart';
import 'package:movie_app/movie/domain/useCase/getCastUseCase.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';

import '../../../core/error/faliure.dart';
import '../entities/cast.dart';
import '../entities/movie.dart';
import '../useCase/movieRecommendation_useCase.dart';

abstract class BaseMovieRepository{

  Future<Either<Failure,List<Movie>>> getNowPlaying();
  Future<Either<Failure,List<Movie>>> getPopularPlaying();
  Future<Either<Failure,List<Movie>>> getTopRatedMovie();
  Future<Either<Failure,List<Movie>>> getUpComingMovie();
  Future<Either<Failure,MovieDetails>> getMovieDetails(MovieDetailsParameter parameter);
  Future<Either<Failure,List<Cast>>> getMovieCast(MovieCastParameter parameter);
  Future<Either<Failure,List<Recommendation>>> getMovieRecommendation(MovieRecoParameter parameter);
}