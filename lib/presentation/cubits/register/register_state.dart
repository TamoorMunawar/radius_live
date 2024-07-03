part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}class RegisterFailure extends RegisterState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}class RegisterSuccess extends RegisterState {
  final Register register;

  const RegisterSuccess({required this.register});
  @override
  List<Object> get props => [];
}
