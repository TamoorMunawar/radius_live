part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}class CheckOtpLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
class ForgotPasswordSuccess extends ForgotPasswordState {
  final int otp;

  const ForgotPasswordSuccess({required this.otp});
  @override
  List<Object> get props => [];
}

class CheckOtpSuccess extends ForgotPasswordState {
  final bool otp;

  const CheckOtpSuccess({required this.otp});
  @override
  List<Object> get props => [];
}class ResetPasswordSuccess extends ForgotPasswordState {
  final bool result;

  const ResetPasswordSuccess({required this.result});
  @override
  List<Object> get props => [];
}class ResetPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  const ResetPasswordFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}class CheckOtpFailure extends ForgotPasswordState {
  final String errorMessage;

  const CheckOtpFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}class ResetPasswordLoading extends ForgotPasswordState {

  @override
  List<Object> get props => [];
}
class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
