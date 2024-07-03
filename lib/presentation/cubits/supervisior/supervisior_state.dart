part of 'supervisior_cubit.dart';

abstract class SupervisiorState extends Equatable {
  const SupervisiorState();
}

class SupervisiorInitial extends SupervisiorState {
  @override
  List<Object> get props => [];
}
class SupervisiorLoading extends SupervisiorState {
  @override
  List<Object> get props => [];
}
class SupervisiorSuccess extends SupervisiorState {
  final List<Supervisior>result;

  SupervisiorSuccess({required this.result});
  @override
  List<Object> get props => [];
}
class SupervisiorFailure extends SupervisiorState {
  final String errorMessage;

  SupervisiorFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
