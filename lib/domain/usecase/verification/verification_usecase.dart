import 'package:radar/constants/logger.dart';
import '../../repository/radar_mobile_repository.dart';

class VerificationUsecase {
  final RadarMobileRepository repository;

  VerificationUsecase({required this.repository});

  Future<bool?> sendOtp({String? email, String? number, String? countryCode}) async {
    try {
      return await repository.sendOtp(email: email, number: number, countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("sendOtp::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool?> checkOtp({String? email, String? otp, String? countryCode}) async {
    try {
      return await repository.checkOtp(email: email, otp: otp, isLoginWithMobile: true, countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("checkOtp::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
