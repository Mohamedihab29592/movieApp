import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String content;

  const Review({
    required this.content,
  });

  @override
  List<Object?> get props => [ content];
}