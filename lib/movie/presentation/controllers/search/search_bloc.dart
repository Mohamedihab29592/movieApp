import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';


import '../../../domain/useCase/getSearchUseCase.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';

part 'search_state.dart';



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static SearchBloc get(context) => BlocProvider.of(context);
  final SearchUseCase searchUseCase;
  SearchBloc(this.searchUseCase) : super(  SearchInitial()) {
    on<GetSearchMovieEvent>(getSearchMovie);
  }

  FutureOr<void> getSearchMovie(GetSearchMovieEvent event, Emitter<SearchState> emit)async {
    emit(SearchLoading());
    final result =
    await searchUseCase (MovieSearchParameter(event.title));
    result.fold((l) => emit(SearchError(l.message,

    )), (r) => emit(SearchLoaded(movie:r, )));
  }
}
