import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCase/useCase.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';

import '../../../core/error/faliure.dart';

class GetPopularPlayingUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;
  GetPopularPlayingUseCase(this.baseMovieRepository);



  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameter) async{
    return await baseMovieRepository.getPopularPlaying();

  }
}