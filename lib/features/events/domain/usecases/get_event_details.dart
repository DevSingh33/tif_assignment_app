import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';
import 'package:tif_assignment_app/core/generic_usecase/usecase.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/repositories/events_repository.dart';

///Use case for getting  event's details with passed id in the [Param]
class GetEventDetailsUseCase extends UseCase<EventEntity, Params> {
  final EventsRepository eventsRepository;
  GetEventDetailsUseCase({required this.eventsRepository});
  @override
  Future<Either<Failure, EventEntity>> call(Params params) {
    return eventsRepository.getEventDetails(id: params.number);
  }
}

///Parameter class for passing and integer  
class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object> get props => [number];
}
