part of 'event_detail_cubit.dart';

abstract class EventDetailState extends Equatable {
  const EventDetailState();
}

class EventDetailInitial extends EventDetailState {
  @override
  List<Object> get props => [];
}class EventDetailLoading extends EventDetailState {
  @override
  List<Object> get props => [];
}class EventDetailSuccess extends EventDetailState {
  final EventDetail eventDetail;

  EventDetailSuccess({required this.eventDetail});
  @override
  List<Object> get props => [];
}class EventDetailFailed extends EventDetailState {
  final String errorMessage;

  EventDetailFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
