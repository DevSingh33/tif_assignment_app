// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/search_for_events.dart';

part 'search_event_state.dart';

///Cubit for managing all the possible states for calling [searchEvent] from the repo.
class SearchEventCubit extends Cubit<SearchEventState> {
  final SearchForEventsUseCase searchForEventsUseCase;
  SearchEventCubit({required this.searchForEventsUseCase}) : super(SearchEventInitial());

  Future<void> searchForEvents(String name) async {
    emit(SearchEventLoading());
    final result = await searchForEventsUseCase.call(Params(query: name));
    result.fold((error) {
      emit(SearchEventError(errorMsg: error.message));
    }, (events) {
      emit(SearchEventLoaded(events: events));
    });
  }
}
