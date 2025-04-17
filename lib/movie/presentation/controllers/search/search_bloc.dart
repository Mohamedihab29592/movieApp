import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movie.dart';


import '../../../domain/useCase/get_search_usecase.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';

part 'search_state.dart';



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static SearchBloc get(context) => BlocProvider.of(context);
  final SearchUseCase searchUseCase;

  final TextEditingController searchController = TextEditingController();

  SearchBloc(this.searchUseCase) : super(SearchInitial()) {
    on<GetSearchMovieEvent>(getSearchMovie);
    on<ClearSearchEvent>(clearSearchMovie);
  }

  FutureOr<void> getSearchMovie(GetSearchMovieEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await searchUseCase(MovieSearchParameter(event.title));
    result.fold(
          (l) => emit(SearchError(l.message)),
          (r) => emit(SearchLoaded(movie: r)),
    );
  }

  FutureOr<void> clearSearchMovie(ClearSearchEvent event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}