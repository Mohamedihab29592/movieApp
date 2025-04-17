import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/core/useCase/use_case.dart';
import 'package:movie_app/movie/domain/entities/cast.dart';

import '../repository/movie_repositry.dart';

class MovieCastUseCase extends BaseUseCase<List<Cast>,MovieCastParameter>{
  final BaseMovieRepository baseMovieRepository;
  MovieCastUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Cast>>> call(MovieCastParameter parameter) async{
    return await baseMovieRepository.getMovieCast(parameter);

  }


}


class MovieCastParameter extends Equatable{
  final int id;


  const MovieCastParameter({required this.id});

  @override
  List<Object?> get props => [id];

}
