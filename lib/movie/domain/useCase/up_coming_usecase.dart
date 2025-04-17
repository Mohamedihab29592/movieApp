import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCase/use_case.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movie_repositry.dart';

import '../../../core/error/faliure.dart';

class GetUpComingUseCase extends BaseUseCase<List<Movie>,NoParameters> {
  final BaseMovieRepository baseMovieRepository;
  GetUpComingUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameter)async {
    return await baseMovieRepository.getUpComingMovie();

  }


}