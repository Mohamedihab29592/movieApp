import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCase/useCase.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movieRepositry.dart';

import '../../../core/error/faliure.dart';

class GetNowPlayingUseCase extends BaseUseCase<List<Movie>,NoParameters> {
  final BaseMovieRepository baseMovieRepository;
  GetNowPlayingUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameter)async {
    return await baseMovieRepository.getNowPlaying();

  }


}