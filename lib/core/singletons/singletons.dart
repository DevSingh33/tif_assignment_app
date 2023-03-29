import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tif_assignment_app/core/network/connection_checker.dart';
import 'package:tif_assignment_app/features/events/data/data_sources/remote_data_source.dart';
import 'package:tif_assignment_app/features/events/data/respositories/event_repository_impl.dart';
import 'package:tif_assignment_app/features/events/domain/repositories/events_repository.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/get_event_details.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/get_events.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/search_for_events.dart';

final serviceLocator = GetIt.I;

///[initSingletons] a function that initializes all the singleton instances of dependencies required in the application. 
Future<void> initSingletons() async {
  //------------------------------------------------- Data Layer ------------------------------------------
  //!Data source
  serviceLocator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(dioClient: serviceLocator()));

  //------------------------------------------------- Domain Layer -----------------------------------------
  //! Repository
  serviceLocator.registerLazySingleton<EventsRepository>(
    () => EventRepositoryImpl(connectionChecker: serviceLocator(), remoteDataSource: serviceLocator()),
  );

  //! Use cases
  serviceLocator.registerLazySingleton(() => GetEventsUseCase(eventsRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetEventDetailsUseCase(eventsRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SearchForEventsUseCase(eventsRepository: serviceLocator()));

  //------------------------------------------------- Other -----------------------------------------------------
  //! Core
  serviceLocator.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(internetConnectionChecker: serviceLocator()));

  //------------------------------------------------ External --------------------------------------------------
  //!Dio service
  serviceLocator.registerLazySingleton<Dio>(() => Dio());

  //!Connection checker
  serviceLocator.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
}
