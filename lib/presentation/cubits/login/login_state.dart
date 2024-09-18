part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
final  Login loginModel;

  LoginSuccess({required this.loginModel});
  @override
  List<Object> get props => [];
}
class AppUpdateSuccess extends LoginState {
final  bool result;

AppUpdateSuccess({required this.result});
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
