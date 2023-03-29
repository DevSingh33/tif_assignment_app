import 'package:equatable/equatable.dart';

/// All the failures which will be returned in place of exception for better error handling after the domain layer data flow.

class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}


