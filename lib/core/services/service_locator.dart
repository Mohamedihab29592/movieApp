import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/movie/data/dataSource/home_local_data_source.dart';
import 'package:movie_app/movie/data/dataSource/remoteDataSource.dart';
import 'package:movie_app/movie/data/repository/movieRepoSitry.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';
import 'package:movie_app/movie/domain/useCase/getCastUseCase.dart';
import 'package:movie_app/movie/domain/useCase/getPopularPlaying_useCase.dart';
import 'package:movie_app/movie/domain/useCase/getTopRated_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieDetails_useCase.dart';
import 'package:movie_app/movie/domain/useCase/movieRecommendation_useCase.dart';
import 'package:movie_app/movie/domain/useCase/nowPlaying_useCase.dart';
import 'package:movie_app/movie/presentation/controllers/mainScreen/bloc.dart';

import '../../movie/domain/useCase/getSearchUseCase.dart';
import '../../movie/domain/useCase/upComingUseCase.dart';
import '../../movie/presentation/controllers/cast/cast_bloc.dart';
import '../../movie/presentation/controllers/movieDetails/movie_details_bloc.dart';
import '../../movie/presentation/controllers/search/search_bloc.dart';
import '../error/internetCheck.dart';

final sl = GetIt.instance;


class ServiceLocator{
  void init(){
    ///Bloc
    sl.registerFactory(() => MovieBloc(sl(),sl(),sl(),sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(),sl()));
    sl.registerFactory(() => CastBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    ///usecase
    sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUseCase(sl()));
    sl.registerLazySingleton(() => GetUpComingUseCase(sl()));

    sl.registerLazySingleton(() => MovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => RecommendationUseCase(sl()));

    sl.registerLazySingleton(() => MovieCastUseCase(sl()));

    sl.registerLazySingleton(() => SearchUseCase(sl()));

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