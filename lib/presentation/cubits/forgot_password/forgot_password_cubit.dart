import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/forgot_password/forgot_password_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.usecase) : super(ForgotPasswordInitial());
  final ForgotPasswordUsecase usecase;

  void forgotPassword({String? email, String? countryCode, bool? isLoginWithMobile}) async {
    try {
      emit(ForgotPasswordLoading());
      var result =
          await usecase.forgotPassword(email: email, countryCode: countryCode, isLoginWithMobile: isLoginWithMobile);
      emit(ForgotPasswordSuccess(otp: result ?? 0));
    } on Exception catch (e) {
      emit(
        ForgotPasswordFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void checkOtp({String? email, String? otp, String? countryCode, required bool isLoginWithMobile}) async {
    try {
      emit(CheckOtpLoading());
      bool? result = await usecase.checkOtp(
          email: email, otp: otp, isLoginWithMobile: isLoginWithMobile, countryCode: countryCode);
      emit(CheckOtpSuccess(otp: result ?? false));
    } on Exception catch (e) {
      emit(
        CheckOtpFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void resetPassword(
      {String? email,
      int? otp,
      String? password,
      String? confirmPassword,
      String? countryCode,
      required bool isLoginWithMobile}) async {
    try {
      emit(ResetPasswordLoading());
      bool? result = await usecase.resetPassword(
          email: email,
          otp: otp,
          password: password,
          confirmPassword: confirmPassword,
          isLoginWithMobile: isLoginWithMobile,
          countryCode: countryCode);
      emit(ResetPasswordSuccess(result: result ?? false));
    } on Exception catch (e) {
      emit(
        ResetPasswordFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
