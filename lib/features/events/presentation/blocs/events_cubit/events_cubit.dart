// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/core/generic_usecase/usecase.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/get_events.dart';

part 'events_state.dart';

///Cubit for managing all the possible states for calling [events] from the repo.
class EventsCubit extends Cubit<EventsState> {
  final GetEventsUseCase getEventsUseCase;
  EventsCubit({required this.getEventsUseCase}) : super(EventsInitial());

  Future<void> getEvents() async {
    emit(EventsLoading());
    final result = await getEventsUseCase.call(NoParams());
    result.fold((error) {
      emit(EventsError(errorMsg: error.message));
    }, (events) {
      emit(EventsLoaded(events: events));
    });
  }
}
