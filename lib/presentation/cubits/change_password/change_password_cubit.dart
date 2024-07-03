import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/change_password/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.usecase) : super(ChangePasswordInitial());
  final ChangePasswordUsecase usecase;

  void changePassword({
    String? currentPassword,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      emit(ChangePasswordLoading());
      bool result = await usecase.changePassword(
          currentPassword: currentPassword,
          password: password,
          confirmPassword: confirmPassword);
      emit(ChangePasswordSuccess(result));
    } on Exception catch (e) {
      emit(
        ChangePasswordFailure(
          errorMessage: e.toString(),
        ),
      );
      throw Exception(
        e.toString().substring(11),
      );
    }
  }

  void updateProfile({
    String? name,
    String? image,
    String? number,
  }) async {
    try {
      emit(ChangePasswordLoading());
      bool result =
          await usecase.updateProfile(name: name, image: image, number: number);
      emit(UpdateProfileSuccess(result));
    } on Exception catch (e) {
      emit(
        ChangePasswordFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateProfileV1({
    String? name,
    String? image,
    String? iqamaId,
    String? email,
    String? number,
    String? whatsappNumber,
    String? mobileNumberCountryCode,
    String? whatsappNumberCountryCode,
  }) async {
    try {
      emit(ChangePasswordLoading());
      bool result = await usecase.updateProfileV1(
          whatsappNumberCountryCode: whatsappNumberCountryCode,
          mobileNumberCountryCode: mobileNumberCountryCode,
          name: name,
          image: image,
          number: number,
          whatsappNumber: whatsappNumber,
          email: email,
          iqamaId: iqamaId);
      emit(UpdateProfileSuccess(result));
    } on Exception catch (e) {
      emit(
        ChangePasswordFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
