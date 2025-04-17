
part of 'wish_bloc.dart';


class WishState extends Equatable{


  final List<MovieDetails> wishList;
  final RequestState wishState;
  final String wishMessage;



  const WishState({

    this.wishList = const [],
    this.wishState= RequestState.loading,
    this.wishMessage='',
  });
  WishState copyWith({

    List<MovieDetails>? wishList,
    RequestState? wishState,
    String? wishMessage,
  }){
    return WishState(


      wishList: wishList??this.wishList,
      wishState: wishState??this.wishState,
      wishMessage: wishMessage??this.wishMessage,
    );
  }

  @override
  List<Object?> get props =>[wishState,wishMessage,wishList];

}