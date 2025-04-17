import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/faliure.dart';
import '../../../core/useCase/use_case.dart';
import '../entities/movies_detail.dart';
import '../repository/movie_repositry.dart';

class GetWishlistUseCase extends BaseUseCase<List<MovieDetails>,NoParameters> {
  final BaseMovieRepository baseMovieRepository;
  GetWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<MovieDetails>>> call(NoParameters parameter)async {
    return await baseMovieRepository.getWishListMovie();

  }




}

class AddToWishlistUseCase extends BaseUseCase<void, AddToWishlistParameters> {
  final BaseMovieRepository baseMovieRepository;

  AddToWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, void>> call(AddToWishlistParameters parameter) async {
    return await baseMovieRepository.addToWishlist(parameter);
  }
}

class RemoveFromWishlistUseCase extends BaseUseCase<void, RemoveFromWishlistParameters> {
  final BaseMovieRepository baseMovieRepository;

  RemoveFromWishlistUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, void>> call(RemoveFromWishlistParameters parameter) async {
    return await baseMovieRepository.removeFromWishlist(parameter);
  }
}

class AddToWishlistParameters extends Equatable {
  final MovieDetails movie;

  const AddToWishlistParameters({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWishlistParameters extends Equatable {
  final int movieId;

  const RemoveFromWishlistParameters({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}