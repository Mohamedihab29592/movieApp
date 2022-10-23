part of 'cast_bloc.dart';

 class CastState extends Equatable {
  final List<Cast>? cast;
  final RequestState castState;
  final String castMessage;

  const CastState({ this.cast, this.castState = RequestState.loading, this.castMessage=""});
  @override
  List<Object?> get props => [cast,castState,castMessage];

}


