import 'package:dartz/dartz.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';

abstract class EventsRepository {
  ///[getEvents] will give all the [List<EventEntity>] after calling the remote data source's api
  Future<Either<Failure, List<EventEntity>>> getEvents();
  ///[getEventDetails]will give the details of the passed id event,after calling the remote data source's api
  Future<Either<Failure, EventEntity>> getEventDetails({required int id});
  ///[searchForEvents]will give all the event related to the passed query,after calling the remote data source's api
  Future<Either<Failure, List<EventEntity>>> searchForEvents({required String searchQuery});
}
