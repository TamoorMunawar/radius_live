part of 'usher_cubit.dart';

abstract class UsherState extends Equatable {
  const UsherState();
}

class UsherInitial extends UsherState {
  @override
  List<Object> get props => [];
}
class UsherLoading extends UsherState {
  @override
  List<Object> get props => [];
}
class UsherSuccess extends UsherState {
  final List<Ushers>usherList;

  UsherSuccess({required this.usherList});
  @override
  List<Object> get props => [];
}
class UsherFailure extends UsherState {
  final String errorMessage;

  UsherFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
