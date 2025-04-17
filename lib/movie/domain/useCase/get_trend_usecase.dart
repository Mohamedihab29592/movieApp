import 'package:dartz/dartz.dart';

import '../../../core/error/faliure.dart';
import '../../../core/useCase/use_case.dart';
import '../entities/movie.dart';
import '../repository/movie_repositry.dart';

class GetTrendUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;
  GetTrendUseCase(this.baseMovieRepository);



  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameter) async{
    return await baseMovieRepository.getTrend();

  }
}