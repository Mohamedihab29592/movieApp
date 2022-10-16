import 'package:dartz/dartz.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';

import '../../../core/error/faliure.dart';

class GetPopularPlayingUseCase {
  final BaseMovieRepository baseMovieRepository;
  GetPopularPlayingUseCase(this.baseMovieRepository);

  Future<Either<Failure,List<Movie>>> execute() async{
    return await baseMovieRepository.getPopularPlaying();
  }
}