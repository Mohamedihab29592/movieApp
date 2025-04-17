import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/useCase/use_case.dart';
import 'package:movie_app/movie/domain/entities/movie.dart';
import 'package:movie_app/movie/domain/repository/movie_repositry.dart';

import '../../../core/error/faliure.dart';

class SearchUseCase extends BaseUseCase<List<Movie>,MovieSearchParameter> {
  final BaseMovieRepository baseMovieRepository;
  SearchUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(MovieSearchParameter parameter)async {
    return await baseMovieRepository.getSearchMovie(parameter);

  }


}
class MovieSearchParameter extends Equatable{
 final  String  text;


    const MovieSearchParameter( this.text);

  @override
  List<Object> get props => [text];

}