import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/usecase/supervisor/supervisior_usecase.dart';

part 'supervisior_state.dart';

class SupervisiorCubit extends Cubit<SupervisiorState> {
  final SupervisiorUsecase usecase;

  SupervisiorCubit(this.usecase) : super(SupervisiorInitial());

  void getSupervisior(
      ) async {
    try {
      emit(SupervisiorLoading());
      List<Supervisior>? result = await usecase.getSuperVisior(
        );
      emit(SupervisiorSuccess(result: result));
    } on Exception catch (e) {
      emit(
        SupervisiorFailure(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
