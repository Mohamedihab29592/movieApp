import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/core/useCase/useCase.dart';

import '../entities/recommendation.dart';
import '../repository/movieRepositry.dart';

class RecommendationUseCase extends BaseUseCase<List<Recommendation>,MovieRecoParameter>{
  final BaseMovieRepository baseMovieRepository;
  RecommendationUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Recommendation>>> call(MovieRecoParameter parameter)async {
    return await baseMovieRepository.getMovieRecommendation(parameter);

  }

}

class MovieRecoParameter extends Equatable{
  final int id;


  const MovieRecoParameter({required this.id});

  @override
  List<Object?> get props => [id];

}
