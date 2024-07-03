part of 'initial_event_cubit.dart';

abstract class InitialEventState extends Equatable {
  const InitialEventState();
}

class InitialEventInitial extends InitialEventState {
  @override
  List<Object> get props => [];
}

class InitialEventLoading extends InitialEventState {
  @override
  List<Object> get props => [];
}

class InitialEventSuccess extends InitialEventState {
  final List<InitialEvent> initialEvent;

  InitialEventSuccess({required this.initialEvent});

  @override
  List<Object> get props => [];
}

class InitialEventFailure extends InitialEventState {
  final String errorMessage;

  InitialEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
class FinalEventLoading extends InitialEventState {
  @override
  List<Object> get props => [];
}

class FinalEventSuccess extends InitialEventState {
  final List<InitialEvent> finalEvent;

  const FinalEventSuccess({required this.finalEvent});

  @override
  List<Object> get props => [];
}

class FinalEventFailure extends InitialEventState {
  final String errorMessage;

  const FinalEventFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
