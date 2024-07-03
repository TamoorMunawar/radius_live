import 'package:equatable/equatable.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();
}

class InitialState extends VerificationState {
  @override
  List<Object> get props => [];
}

class CheckOtpLoading extends VerificationState {
  @override
  List<Object> get props => [];
}

class CheckOtpSuccess extends VerificationState {
  final bool otp;

  const CheckOtpSuccess({required this.otp});
  @override
  List<Object> get props => [];
}

class CheckOtpFailure extends VerificationState {
  final String errorMessage;

  const CheckOtpFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class SendOtpLoading extends VerificationState {
  @override
  List<Object> get props => [];
}

class SendOtpSuccess extends VerificationState {
  final bool success;

  const SendOtpSuccess({required this.success});
  @override
  List<Object> get props => [];
}

class SendOtpFailure extends VerificationState {
  final String errorMessage;

  const SendOtpFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
