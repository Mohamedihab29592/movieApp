import 'package:dartz/dartz.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';

import '../../../core/error/faliure.dart';

class GetNowPlayingUseCase {
  final BaseMovieRepository baseMovieRepository;
  GetNowPlayingUseCase(this.baseMovieRepository);

  Future<Either<Failure,List<Movie>>> execute() async{
    return await baseMovieRepository.getNowPlaying();
  }
}