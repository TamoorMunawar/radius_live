import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/domain/usecase/verification/verification_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationUsecase _usecase;
  VerificationCubit(this._usecase) : super(InitialState());

  Future<void> checkOtp({String? email, String? otp, String? countryCode}) async {
    try {
      emit(CheckOtpLoading());
      bool? result = await _usecase.checkOtp(email: email, otp: otp, countryCode: countryCode);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isVerified", true);

      emit(CheckOtpSuccess(otp: result ?? false));
    } on Exception catch (e) {
      emit(
        CheckOtpFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> sendOtp({String? email, String? number, String? countryCode}) async {
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
