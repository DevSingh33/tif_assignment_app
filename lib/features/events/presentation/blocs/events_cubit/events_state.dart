part of 'events_cubit.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<EventEntity> events;
  const EventsLoaded({required this.events});
}

class EventsError extends EventsState {
  final String errorMsg;
  const EventsError({required this.errorMsg});
}
