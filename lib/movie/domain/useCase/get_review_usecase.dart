import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/faliure.dart';
import 'package:movie_app/core/useCase/use_case.dart';
import 'package:movie_app/movie/domain/entities/review.dart';
import '../repository/movie_repositry.dart';

class MovieReviewUseCase extends BaseUseCase<List<Review>,MovieReviewParameter>{
  final BaseMovieRepository baseMovieRepository;
  MovieReviewUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Review>>> call(MovieReviewParameter parameter) async{
    return await baseMovieRepository.getMovieReview(parameter);

  }


}


class MovieReviewParameter extends Equatable{
  final int id;


  const MovieReviewParameter({required this.id});

  @override
  List<Object?> get props => [id];

}
