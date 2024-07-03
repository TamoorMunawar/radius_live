import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/register/Register.dart';
import 'package:radar/domain/entities/register_payload/Register_payload.dart';
import 'package:radar/domain/usecase/register/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase usecase;
  RegisterCubit(this.usecase) : super(RegisterInitial());
  void register({RegisterPayload ?registerPayload,String?documentPath}) async {
    try {
      emit(RegisterLoading());
      Register? result = await usecase.register(registerPayload: registerPayload,documentPath: documentPath);
      emit(RegisterSuccess(register: result));
    } on Exception catch (e) {
      emit(
        RegisterFailure(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
