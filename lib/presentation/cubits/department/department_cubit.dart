import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/usecase/department/department_usecase.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
    final DepartmentUsecase usecase;
  DepartmentCubit(this.usecase) : super(DepartmentInitial());
  void getDepartment() async {
    try {
      emit(DepartmentLoading());
      List<Department> result = await usecase.getDepartment();
      emit(DepartmentSuccess(departmentList: result ));
    } on Exception catch (e) {
      emit(
        DepartmentFailure(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
