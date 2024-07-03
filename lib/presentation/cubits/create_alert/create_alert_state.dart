part of 'create_alert_cubit.dart';

abstract class CreateAlertState extends Equatable {
  const CreateAlertState();
}

class CreateAlertInitial extends CreateAlertState {
  @override
  List<Object> get props => [];
}class CreateAlertSuccess extends CreateAlertState {
  final bool result;

  CreateAlertSuccess({required this.result});
  @override
  List<Object> get props => [];
}class CreateAlertLoading extends CreateAlertState {
  @override
  List<Object> get props => [];
}class CreateAlertFailure extends CreateAlertState {
  final String errorMessage;

  CreateAlertFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
