
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/local/cache_helper.dart';
import 'package:movie_app/core/network/error_message_model.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:movie_app/movie/data/models/movie_details_model.dart';
import 'package:movie_app/movie/data/models/movie_model.dart';
import 'package:movie_app/movie/data/models/review_model.dart';
import 'package:movie_app/movie/domain/useCase/get_cast_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_search_usecase.dart';
import 'package:movie_app/movie/domain/useCase/movie_details_usecase.dart';

import '../../domain/useCase/get_review_usecase.dart';
import '../models/cast_model.dart';

abstract class BaseMovieRemoteDataSource{
  Future<List<MovieModel>> getTrendMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularPlaying();
  Future<List<MovieModel>> getTopRatedMovie();
  Future<List<MovieModel>> getUpComingMovie();
  Future<List<MovieModel>> getSearchMovie(MovieSearchParameter parameter);
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameter parameter);
  Future<List<MovieCastModel>> getMovieCast(MovieCastParameter parameter);
  Future<List<MovieReviewModel>> getMovieReview(MovieReviewParameter parameter);
}



class MovieRemoteDataSource extends BaseMovieRemoteDataSource {

  @override
  Future<List<MovieModel>> getTrendMovies() async{
    final response = await Dio().get(AppConstants.trendPath);
    if(response.statusCode== 200){
      CacheHelper.saveData(key: "cachedTrendLocalData", value: response.data.toString());
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }else
    {
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }

  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
final response = await Dio().get(AppConstants.nowPlayingPath);
if(response.statusCode== 200){
 CacheHelper.saveData(key: "cachedNowPlayingLocalData", value: response.data.toString());
 return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
}
else
  {
    throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
  }

}

  @override
  Future<List<MovieModel>> getPopularPlaying() async{
    final response = await Dio().get(AppConstants.popularPlayingPath);

    if(response.statusCode== 200){
      CacheHelper.saveData(key: "cachedPopularLocalData", value: response.data.toString());

      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else
    {
    throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie()async {

    final response = await Dio().get(AppConstants.getTopRatedMoviePath);

    if(response.statusCode== 200){
      CacheHelper.saveData(key: "cachedTopRatedLocalData", value: response.data.toString());

      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else
    {
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }

  @override
  Future<List<MovieModel>> getUpComingMovie() async{
    final response = await Dio().get(AppConstants.getUpComingMoviePath);

    if(response.statusCode== 200){
      CacheHelper.saveData(key: "cachedUpComingLocalData", value: response.data.toString());


      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else
    {

      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }

  @override
  Future<List<MovieModel>> getSearchMovie(MovieSearchParameter parameter) async{
    final response = await Dio().get(AppConstants.getSearchPath(parameter.text));

    if(response.statusCode== 200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else
    {

      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameter parameter) async{
    final response = await Dio().get(AppConstants.getMovieDetailsPath(parameter.id));

    if(response.statusCode== 200){
      return MovieDetailsModel.fromJson(response.data);
    }
    else
    {
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }


  @override
  Future<List<MovieCastModel>> getMovieCast(MovieCastParameter parameter) async{
    final response = await Dio().get(AppConstants.movieCast(parameter.id));
    if(response.statusCode== 200){

      return List<MovieCastModel>.from(
          response.data['cast'].map((e) => MovieCastModel.fromJson(e)));    }
    else
    {
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }

  @override
  Future<List<MovieReviewModel>> getMovieReview(MovieReviewParameter parameter) async {
    final response = await Dio().get(AppConstants.getMovieReviewPath(parameter.id));

    if (response.statusCode == 200) {
      return List<MovieReviewModel>.from(
          (response.data['results'] as List).map((e) => MovieReviewModel.fromJson(e))
      );

    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }





}