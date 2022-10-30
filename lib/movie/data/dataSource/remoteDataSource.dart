
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/local/cache_helper.dart';
import 'package:movie_app/core/network/errorMessageModel.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:movie_app/movie/data/models/movieDetailsModel.dart';
import 'package:movie_app/movie/data/models/movieModel.dart';
import 'package:movie_app/movie/data/models/recommendationModel.dart';
import 'package:movie_app/movie/domain/useCase/getCastUseCase.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieRecommendation_useCase.dart';

import '../models/castModel.dart';

abstract class BaseMovieRemoteDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularPlaying();
  Future<List<MovieModel>> getTopRatedMovie();
  Future<List<MovieModel>> getUpComingMovie();
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameter parameter);
  Future<List<MovieCastModel>> getMovieCast(MovieCastParameter parameter);
  Future<List<RecommendationsModel>> getMovieRecommendation(MovieRecoParameter parameter);
}



class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
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
  Future<List<RecommendationsModel>> getMovieRecommendation(MovieRecoParameter parameter)async {
    final response = await Dio().get(AppConstants.getMovieRecommendationPath(parameter.id));

    if(response.statusCode== 200){

      return List<RecommendationsModel>.from((response.data["results"]as List).map((e) => RecommendationsModel.fromJson(e),));
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



}