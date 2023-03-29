import 'package:tif_assignment_app/core/errors/error_messages.dart';
import 'package:tif_assignment_app/core/errors/exceptions.dart';
import 'package:tif_assignment_app/core/network/connection_checker.dart';
import 'package:tif_assignment_app/features/events/data/data_sources/remote_data_source.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tif_assignment_app/features/events/domain/repositories/events_repository.dart';

class EventRepositoryImpl implements EventsRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  EventRepositoryImpl({required this.remoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, EventEntity>> getEventDetails({required int id}) async {
    if (await connectionChecker.isConnected) {
      try {
        final result = await remoteDataSource.fetchEventDetailsById(id: id);
        return Right(result as EventEntity);
      } on UnknownException {
        return const Left(Failure(message: ErrorMessages.kErrorCheckConnection));
      } catch (e) {
        return const Left(Failure(message: ErrorMessages.kUnknownError));
      }
    } else {
      return const Left(NetworkFailure(message: ErrorMessages.kErrorCheckConnection));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    if (await connectionChecker.isConnected) {
      try {
        final result = await remoteDataSource.fetchEvents();
        return Right(result);
      } on UnknownException {
        return const Left(Failure(message: ErrorMessages.kErrorCheckConnection));
      } catch (e) {
        return const Left(Failure(message: ErrorMessages.kUnknownError));
      }
    } else {
      return const Left(NetworkFailure(message: ErrorMessages.kErrorCheckConnection));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> searchForEvents({required String searchQuery}) async {
    if (await connectionChecker.isConnected) {
      try {
        final result = await remoteDataSource.fetchEventsByQuery(query: searchQuery);
        return Right(result);
      } on UnknownException {
        return const Left(Failure(message: ErrorMessages.kErrorCheckConnection));
      } catch (e) {
        return const Left(Failure(message: ErrorMessages.kUnknownError));
      }
    } else {
      return const Left(NetworkFailure(message: ErrorMessages.kErrorCheckConnection));
    }
  }
}
