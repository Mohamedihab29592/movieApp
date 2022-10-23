part of 'cast_bloc.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();
}
class GetCastEvent extends CastEvent{
  final int id;

  const GetCastEvent(this.id);
  @override
  List<Object?> get props => [id];
}

