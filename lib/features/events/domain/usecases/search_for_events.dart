import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';
import 'package:tif_assignment_app/core/generic_usecase/usecase.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/repositories/events_repository.dart';

///Use case for getting all event with matching passed query in the [Param]
class SearchForEventsUseCase extends UseCase<List<EventEntity>, Params> {
  final EventsRepository eventsRepository;
  SearchForEventsUseCase({required this.eventsRepository});
  @override
  Future<Either<Failure, List<EventEntity>>> call(Params params) {
    return eventsRepository.searchForEvents(searchQuery: params.query);
  }
}

class Params extends Equatable {
  final String query;

  const Params({required this.query});

  @override
  List<Object> get props => [query];
}
