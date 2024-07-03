part of 'department_cubit.dart';

abstract class DepartmentState extends Equatable {
  const DepartmentState();
}

class DepartmentInitial extends DepartmentState {
  @override
  List<Object> get props => [];
}class DepartmentLoading extends DepartmentState {
  @override
  List<Object> get props => [];
}class DepartmentSuccess extends DepartmentState {
 final List <Department> departmentList;

  DepartmentSuccess({required this.departmentList});
  @override
  List<Object> get props => [];
}class DepartmentFailure extends DepartmentState {
  final String errorMessage;

  DepartmentFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
