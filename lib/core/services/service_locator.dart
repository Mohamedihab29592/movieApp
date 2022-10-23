import 'package:get_it/get_it.dart';
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

import '../../movie/domain/useCase/upComingUseCase.dart';
import '../../movie/presentation/controllers/cast/cast_bloc.dart';
import '../../movie/presentation/controllers/movieDetails/movie_details_bloc.dart';

final sl = GetIt.instance;


class ServiceLocator{
  void init(){
    ///Bloc
    sl.registerFactory(() => MovieBloc(sl(),sl(),sl(),sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl(),sl()));
    sl.registerFactory(() => CastBloc(sl()));
    ///usecase
    sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularPlayingUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUseCase(sl()));
    sl.registerLazySingleton(() => GetUpComingUseCase(sl()));

    sl.registerLazySingleton(() => MovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => MovieCastUseCase(sl()));
    sl.registerLazySingleton(() => RecommendationUseCase(sl()));
    ///Repositary
    sl.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(sl()));
    ///Data sourse
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());

  }

}