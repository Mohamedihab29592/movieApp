import 'package:dartz/dartz.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';
import 'package:movie_app/movie/domain/useCase/get_cast_usecase.dart';
import 'package:movie_app/movie/domain/useCase/movie_details_usecase.dart';
import '../../../core/error/faliure.dart';
import '../entities/cast.dart';
import '../entities/movie.dart';
import '../entities/review.dart';
import '../useCase/get_review_usecase.dart';
import '../useCase/get_search_usecase.dart';
import '../useCase/wishlist_usecase.dart';

abstract class BaseMovieRepository{

  Future<Either<Failure,List<Movie>>> getTrend();
  Future<Either<Failure,List<Movie>>> getNowPlaying();
  Future<Either<Failure,List<Movie>>> getPopularPlaying();
  Future<Either<Failure,List<Movie>>> getTopRatedMovie();
  Future<Either<Failure,List<Movie>>> getUpComingMovie();
  Future<Either<Failure,List<MovieDetails>>> getWishListMovie();
  Future<Either<Failure,List<Movie>>> getSearchMovie(MovieSearchParameter parameter);
  Future<Either<Failure,MovieDetails>> getMovieDetails(MovieDetailsParameter parameter);
  Future<Either<Failure,List<Cast>>> getMovieCast(MovieCastParameter parameter);
  Future<Either<Failure,List<Review>>> getMovieReview(MovieReviewParameter parameter);
  Future<Either<Failure, void>> addToWishlist(AddToWishlistParameters parameter);
  Future<Either<Failure, void>> removeFromWishlist(RemoveFromWishlistParameters parameter);
}