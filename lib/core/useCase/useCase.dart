import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/faliure.dart';

abstract class BaseUseCase<T, Parameter>{

  Future<Either<Failure,T>> call(Parameter parameter);
}

class NoParameters extends Equatable {
 const  NoParameters();
  @override
  List<Object?> get props => [];
}