import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/useCase/use_case.dart';
import '../../../../core/utilies/enum.dart';
import '../../../domain/entities/movies_detail.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/useCase/wishlist_usecase.dart';

part 'event.dart';

part 'state.dart';



class WishBloc extends Bloc<WishEvents, WishState> {

  final GetWishlistUseCase getWishListUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;

  WishBloc(this.getWishListUseCase,this.addToWishlistUseCase,this.removeFromWishlistUseCase)
      : super( const WishState()) {
    on<GetWishListEvent>(_getWishListMovies);
    on<RemoveFromWishListEvent>(_removeFromWishList);
    on<AddToWishListEvent>(_addToWishList);
  }

  FutureOr<void>  _getWishListMovies(GetWishListEvent event, Emitter<WishState> emit) async {
    final result = await getWishListUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            wishState: RequestState.error, wishMessage: l.message)),
            (r) => emit(state.copyWith(
          wishList: r,
          wishState: RequestState.loaded,
        )));
  }

  FutureOr<void> _addToWishList(AddToWishListEvent event, Emitter<WishState> emit) async {
    emit(state.copyWith(wishState: RequestState.loading));

    final result = await addToWishlistUseCase(
        AddToWishlistParameters(movie: event.movie)
    );
    await result.fold(
          (failure) async {
        emit(state.copyWith(
          wishState: RequestState.error,
          wishMessage: failure.message,
        ));
      },
          (_) async {
        final wishlistResult = await getWishListUseCase(const NoParameters());

        wishlistResult.fold(
              (failure) {
            if (!emit.isDone) {
              emit(state.copyWith(
                wishState: RequestState.error,
                wishMessage: failure.message,
              ));
            }
          },
              (updatedWishlist) {
            if (!emit.isDone) {
              emit(state.copyWith(
                wishList: updatedWishlist,
                wishState: RequestState.loaded,
              ));
            }
          },
        );
      },
    );
  }
  FutureOr<void> _removeFromWishList(RemoveFromWishListEvent event, Emitter<WishState> emit) async {
    emit(state.copyWith(wishState: RequestState.loading));

    final result = await removeFromWishlistUseCase(
        RemoveFromWishlistParameters(movieId: event.movieId)
    );

    await result.fold(
          (failure) async {
        if (!emit.isDone) {
          emit(state.copyWith(
            wishState: RequestState.error,
            wishMessage: failure.message,
          ));
        }
      },
          (_) async {
        final wishlistResult = await getWishListUseCase(const NoParameters());

        wishlistResult.fold(
              (failure) {
            if (!emit.isDone) {
              emit(state.copyWith(
                wishState: RequestState.error,
                wishMessage: failure.message,
              ));
            }
          },
              (updatedWishlist) {
            if (!emit.isDone) {
              emit(state.copyWith(
                wishList: updatedWishlist,
                wishState: RequestState.loaded,
              ));
            }
          },
        );
      },
    );
  }}
