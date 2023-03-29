// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/domain/usecases/get_event_details.dart';

part 'event_detail_state.dart';


///Cubit for managing all the possible states for calling [eventDetails] from the repo.
class EventDetailCubit extends Cubit<EventDetailState> {
  final GetEventDetailsUseCase getEventDetailsUseCase;
  EventDetailCubit({required this.getEventDetailsUseCase}) : super(EventDetailInitial());
  
  Future<void> getEventDetails(int id) async {
    emit(EventDetailLoading());
    final result = await getEventDetailsUseCase.call(Params(number: id));
    
    //[result.fold] will give either (error) or (event)
    result.fold((error) {
      emit(EventDetailError(errorMsg: error.message));
    }, (event) {
      emit(EventDetailLoaded(event: event));
    });
  }
}
