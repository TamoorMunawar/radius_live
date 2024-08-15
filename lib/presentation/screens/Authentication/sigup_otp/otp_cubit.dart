import 'package:bloc/bloc.dart';
import 'package:radar/presentation/screens/Authentication/sigup_otp/repositery.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/usecase/verification/verification_usecase.dart';
import '../../../cubits/forgot_password/forgot_password_cubit.dart';
import 'otp_screen.dart';

class OtpCubit extends Cubit<VerificationState> {
  final VerificationUsecase _usecase;

  OtpCubit(this._usecase) : super(VerificationInitial());
  Future<void> checkOtp({String? email, String? otp, String? countryCode}) async {
    try {
      emit(VerificationLoading());
      bool? result = await _usecase.checkOtp(email: email, otp: otp, countryCode: countryCode);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isVerified", true);

      emit(VerificationSuccess(otp: result ?? false));
    } on Exception catch (e) {
      emit(
        VerificationFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

}

// States
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final bool otp;

   VerificationSuccess({required this.otp});
  @override
  List<Object> get props => [];
}
class VerificationFailure extends VerificationState {
  final String errorMessage;

   VerificationFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

