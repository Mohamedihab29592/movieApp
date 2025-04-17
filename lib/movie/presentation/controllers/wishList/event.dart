
part of 'wish_bloc.dart';

abstract class WishEvents extends Equatable{
  const WishEvents();

  @override
  List<Object?> get props => [];
}

class GetWishListEvent extends WishEvents{}

class RemoveFromWishListEvent extends WishEvents {
  final int movieId;

  const RemoveFromWishListEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class AddToWishListEvent extends WishEvents {
  final MovieDetails movie;

  const AddToWishListEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}
