import 'dart:convert';

import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/movie/data/models/movieModel.dart';

import '../../../core/local/cache_helper.dart';

abstract class BaseMovieDataLocalDataSource {
  Future<List<MovieModel>> getTrendLocalData();
  Future<List<MovieModel>> getNowPlayingLocalData();
  Future<List<MovieModel>> getPopularLocalData();
  Future<List<MovieModel>> getTopRatedLocalData();
  Future<List<MovieModel>> getUpComingLocalData();

  Future<void> cachedTrendLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedNowPlayingLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedPopularLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedTopRatedLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedUpComingLocalData({required  List<MovieModel>  movieModel});
}

class MovieDataLocalDataSourceImpl implements BaseMovieDataLocalDataSource {
  @override
  Future<List<MovieModel>> getTrendLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedTrendLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    } else {
      throw const LocalExceptions(message: "no data");
    }
  }
  @override
  Future<List<MovieModel>> getNowPlayingLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedNowPlayingLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    } else {
      throw const LocalExceptions(message: "no data");
    }
  }



  @override
  Future<List<MovieModel>> getPopularLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedPopularLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    } else {
      throw const LocalExceptions(message: "no data");
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedTopRatedLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    } else {
      throw const LocalExceptions(message: "no data");
    }
  }

  @override
  Future<List<MovieModel>> getUpComingLocalData() {
    final jsonString = CacheHelper.getData(key: 'cachedUpComingLocalData');
    if (jsonString != null) {
      final cachedHomeData = List<MovieModel>.from(
          (json.decode(jsonString)).map((e) => MovieModel.fromJson(e),));
      return Future.value(cachedHomeData);
    } else {
      throw const LocalExceptions(message: "no data");
    }
  }
  @override
  Future<void> cachedTrendLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedTrendLocalData', value: jsonEncode(movieModel.toList()));
  }
  @override
  Future<bool> cachedNowPlayingLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedNowPlayingLocalData', value: jsonEncode(movieModel.toList()));
  }
  @override
  Future<void> cachedPopularLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedPopularLocalData', value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<void> cachedTopRatedLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedTopRatedLocalData', value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<void> cachedUpComingLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedUpComingLocalData', value: jsonEncode(movieModel.toList()));
  }




}