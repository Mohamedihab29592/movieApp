import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/movie/data/dataSource/home_local_data_source.dart';
import 'package:movie_app/movie/data/dataSource/remote_data_source.dart';
import 'package:movie_app/movie/data/repository/movie_repo.dart';
import 'package:movie_app/movie/domain/repository/movie_repositry.dart';
import 'package:movie_app/movie/domain/useCase/get_cast_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_popular_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_review_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_toprated_usecase.dart';
import 'package:movie_app/movie/domain/useCase/get_trend_usecase.dart';
import 'package:movie_app/movie/domain/useCase/movie_details_usecase.dart';
import 'package:movie_app/movie/domain/useCase/now_playing_usecase.dart';
import 'package:movie_app/movie/domain/useCase/wishlist_usecase.dart';

import '../../movie/domain/useCase/get_search_usecase.dart';
import '../../movie/domain/useCase/up_coming_usecase.dart';
import '../error/internet_check.dart';

final sl = GetIt.instance;


class ServiceLocator{
  void init(){

    ///usecase
    sl.registerLazySingleton(() => GetTrendUseCase(sl()));
    sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUseCase(sl()));
    sl.registerLazySingleton(() => GetUpComingUseCase(sl()));

    sl.registerLazySingleton(() => MovieDetailsUseCase(sl()));

    sl.registerLazySingleton(() => MovieCastUseCase(sl()));

    sl.registerLazySingleton(() => MovieReviewUseCase(sl()));

    sl.registerLazySingleton(() => SearchUseCase(sl()));

    sl.registerLazySingleton(() => AddToWishlistUseCase(sl()));
    sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl()));
    sl.registerLazySingleton(() => GetWishlistUseCase(sl()));


    ///Repositary
    sl.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(sl(),sl(),sl()));
    ///Data source
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
    sl.registerLazySingleton<BaseMovieDataLocalDataSource>(() => MovieDataLocalDataSourceImpl());

    ///core
     sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
    sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  }

}