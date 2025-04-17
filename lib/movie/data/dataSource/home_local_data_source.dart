import 'dart:convert';

import 'package:movie_app/core/error/exceptions.dart';

import '../../../core/local/cache_helper.dart';
import '../../domain/entities/movies_detail.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class BaseMovieDataLocalDataSource {
  Future<List<MovieModel>> getTrendLocalData();
  Future<List<MovieModel>> getNowPlayingLocalData();
  Future<List<MovieModel>> getPopularLocalData();
  Future<List<MovieModel>> getTopRatedLocalData();
  Future<List<MovieModel>> getUpComingLocalData();
  Future<List<MovieDetails>> getWishLocalData();


  Future<void> cachedTrendLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedNowPlayingLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedPopularLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedTopRatedLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedUpComingLocalData({required  List<MovieModel>  movieModel});
  Future<void> cachedWishLocalData({required  List<MovieDetails>  movieModel});
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
  Future<List<MovieDetailsModel>> getWishLocalData() async {
    final jsonString = CacheHelper.getData(key: 'cachedWishLocalData');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList
          .map((json) => MovieDetailsModel.fromJson(json))
          .toList();
    } else {
      return Future.value([]);
    }
  }


  @override
  Future<void> cachedTrendLocalData({required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedTrendLocalData', value: jsonEncode(movieModel.toList()));
  }

  @override
  Future<bool> cachedNowPlayingLocalData(
      {required List<MovieModel> movieModel}) {
    return CacheHelper.saveData(
        key: 'cachedNowPlayingLocalData',
        value: jsonEncode(movieModel.toList()));
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


  @override
  Future<void> cachedWishLocalData({required List<MovieDetails> movieModel}) {
    final List<Map<String, dynamic>> jsonList =
    movieModel.map((movie) => (movie as MovieDetailsModel).toJson()).toList();

    return CacheHelper.saveData(
        key: 'cachedWishLocalData',
        value: jsonEncode(jsonList)
    );
  }

}



