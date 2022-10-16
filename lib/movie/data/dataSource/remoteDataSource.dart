import 'package:dio/dio.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/network/errorMessageModel.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:movie_app/movie/data/models/movieModel.dart';

abstract class BaseRemoteDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularPlaying();
  Future<List<MovieModel>> getTopRatedMovie();
}



class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
final response = await Dio().get(AppConstants.nowPlayingPath);

if(response.statusCode== 200){
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
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e),));
    }
    else
    {
      throw ServerExceptions(errorMessageModel: ErrorMessageModel.fromJson(response.data),);
    }
  }
}