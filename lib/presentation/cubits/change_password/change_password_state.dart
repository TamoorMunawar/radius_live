part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}
class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object> get props => [];
}
class ChangePasswordSuccess extends ChangePasswordState {
  final bool result;

  const ChangePasswordSuccess(this.result);
  @override
  List<Object> get props => [];
}class UpdateProfileSuccess extends ChangePasswordState {
  final bool result;

  const UpdateProfileSuccess(this.result);
  @override
  List<Object> get props => [];
}
class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
