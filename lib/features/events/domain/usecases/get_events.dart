import 'package:dartz/dartz.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';
import 'package:tif_assignment_app/core/generic_usecase/usecase.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/repositories/events_repository.dart';


///Use case for getting all events with  [NoParam] as parameter
class GetEventsUseCase extends UseCase<List<EventEntity>, NoParams> {
  final EventsRepository eventsRepository;
  GetEventsUseCase({required this.eventsRepository});
  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) {
    return eventsRepository.getEvents();
  }
}
