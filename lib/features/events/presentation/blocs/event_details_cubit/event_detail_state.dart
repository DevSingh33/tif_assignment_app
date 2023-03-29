part of 'event_detail_cubit.dart';

abstract class EventDetailState extends Equatable {
  const EventDetailState();

  @override
  List<Object> get props => [];
}

class EventDetailInitial extends EventDetailState {}

class EventDetailLoading extends EventDetailState {}

class EventDetailLoaded extends EventDetailState {
  final EventEntity event;
  const EventDetailLoaded({required this.event});
}

class EventDetailError extends EventDetailState {
  final String errorMsg;
  const EventDetailError({required this.errorMsg});
}
