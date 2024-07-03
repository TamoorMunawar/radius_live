import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/login/Login.dart';

import 'package:radar/domain/repository/radar_mobile_repository.dart';

class LoginUsecase {
  final RadarMobileRepository repository;

  LoginUsecase({required this.repository});

  Future<Login> login(
      {String? lat,
      String? lng,
      String? email,
      String? password,
      String? deviceToken,
      String? deviceId,
      String? deviceName,
      bool? isLoginWithMobile,
      String? countryCode}) async {
    try {
      return await repository.login(
          lat: lat,
          lng: lng,
          email: email,
          password: password,
          deviceToken: deviceToken,
          deviceId: deviceId,
          deviceName: deviceName,
          isLoginWithMobile: isLoginWithMobile,
          countryCode: countryCode);
    } on Exception catch (e) {
      LogManager.error("login::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool> appUpdate({
    String? appVersion,
  }) async {
    try {
      return await repository.appUpdate(appVersion: appVersion);
    } on Exception catch (e) {
      LogManager.error("appUpdate::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
