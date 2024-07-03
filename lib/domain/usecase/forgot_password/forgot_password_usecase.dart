import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ForgotPasswordUsecase {
  final RadarMobileRepository repository;

  ForgotPasswordUsecase({required this.repository});

  Future<int?> forgotPassword({String? email, String? password, String? countryCode, bool? isLoginWithMobile}) async {
    try {
      return await repository.forgetPassword(
          email: email, isLoginWithMobile: isLoginWithMobile, countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("forgotPassword::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool?> resetPassword(
      {String? email,
      int? otp,
      String? password,
      String? confirmPassword,
      String? countryCode,
      required bool isLoginWithMobile}) async {
    try {
      return await repository.resetPassword(
          email: email,
          otp: otp,
          password: password,
          confirmPassword: confirmPassword,
          isLoginWithMobile: isLoginWithMobile,
          countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("resetPassword::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool?> checkOtp({String? email, String? otp, String? countryCode, required bool isLoginWithMobile}) async {
    try {
      return await repository.checkOtp(
          email: email, otp: otp, isLoginWithMobile: isLoginWithMobile, countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("checkOtp::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
