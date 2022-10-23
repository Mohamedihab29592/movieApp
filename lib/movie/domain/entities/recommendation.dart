import 'package:equatable/equatable.dart';

class Recommendation extends Equatable{
  final int id;
  final String? posterPath;
  final String? backdropPath;

  const Recommendation({required this.id, this.posterPath,required this.backdropPath});

  @override
  List<Object?> get props => [id,posterPath,backdropPath];
}