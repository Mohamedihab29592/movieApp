
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchMovieEvent extends SearchEvent {

  final String title;

  const GetSearchMovieEvent(this.title);
}
class ClearSearchEvent extends SearchEvent {}
