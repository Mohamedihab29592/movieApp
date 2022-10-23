import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/movie/domain/entities/cast.dart';
import 'package:movie_app/movie/domain/useCase/getCastUseCase.dart';

import '../../../../core/utilies/enum.dart';

part 'cast_event.dart';

part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final MovieCastUseCase movieCastUseCase;

  CastBloc(this.movieCastUseCase) : super(const CastState()) {
    on<GetCastEvent>(_getCast);
  }

  FutureOr<void> _getCast(GetCastEvent event, Emitter<CastState> emit) async {
    final result = await movieCastUseCase(MovieCastParameter(id: event.id));
    result.fold(
        (l) => emit(CastState(
            castState: RequestState.error, castMessage: l.message)),
        (r) =>emit( CastState(castState: RequestState.loaded, cast: r)));
  }
}
