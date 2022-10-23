import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/movie/presentation/controllers/refresh/refresh_event.dart';
import 'package:movie_app/movie/presentation/controllers/refresh/refresh_state.dart';


class RefreshBlocBloc extends Bloc<RefreshBlocEvent, RefreshBlocState> {
  RefreshBlocBloc() : super(Loaded());

  Stream<RefreshBlocState> mapEventToState(
      RefreshBlocEvent event,
      ) async* {
    if (event is RefreshEvnt) {
      yield Loading();

      // During the Loading state we can do additional checks like,
      // if the internet connection is available or not etc..
      await Future.delayed(
        const Duration(seconds: 4),
      ); // This is to simulate that refresh process

      yield Loaded(); // In this state we can load the expected interface
    }
  }
}