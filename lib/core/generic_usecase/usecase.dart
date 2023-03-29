import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';

///A generic use case that will be implemented by all the usecases.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}