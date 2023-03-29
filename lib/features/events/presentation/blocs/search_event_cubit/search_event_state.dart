part of 'search_event_cubit.dart';

abstract class SearchEventState extends Equatable {
  const SearchEventState();

  @override
  List<Object> get props => [];
}

class SearchEventInitial extends SearchEventState {}

class SearchEventLoading extends SearchEventState {}

class SearchEventLoaded extends SearchEventState {
  final List<EventEntity> events;
  const SearchEventLoaded({required this.events});
}

class SearchEventError extends SearchEventState {
  final String errorMsg;
  const SearchEventError({required this.errorMsg});
}
