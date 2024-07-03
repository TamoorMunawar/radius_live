import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/domain/usecase/verification/verification_usecase.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationUsecase _usecase;
  VerificationCubit(this._usecase) : super(InitialState());

  void checkOtp({String? email, String? otp, String? countryCode}) async {
    try {
      emit(CheckOtpLoading());
      bool? result = await _usecase.checkOtp(email: email, otp: otp, countryCode: countryCode);
      emit(CheckOtpSuccess(otp: result ?? false));
    } on Exception catch (e) {
      emit(
        CheckOtpFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void sendOtp({String? email, String? number, String? countryCode}) async {
    try {
      emit(SendOtpLoading());
      bool? result = await _usecase.sendOtp(email: email, number: number, countryCode: countryCode);
      emit(SendOtpSuccess(success: result ?? false));
    } on Exception catch (e) {
      emit(
        SendOtpFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
