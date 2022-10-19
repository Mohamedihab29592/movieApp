import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/core/useCase/useCase.dart';
import 'package:movie_app/movie/domain/entities/movies_detail.dart';

import '../repository/movieRepositry.dart';

class MovieDetailsUseCase extends BaseUseCase<MovieDetails,MovieDetailsParameter>{
  final BaseMovieRepository baseMovieRepository;
  MovieDetailsUseCase(this.baseMovieRepository);
  @override
  Future<Either<Failure, MovieDetails>> call(MovieDetailsParameter parameter) async{
    return await baseMovieRepository.getMovieDetails(parameter);

  }


}


class MovieDetailsParameter extends Equatable{
  final int id;


  const MovieDetailsParameter({required this.id});

  @override
  List<Object?> get props => [id];

}
