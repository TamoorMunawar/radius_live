import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ChangePasswordUsecase {
  final RadarMobileRepository repository;

  ChangePasswordUsecase({required this.repository});

  Future<bool> changePassword({
    String? currentPassword,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      return await repository.changePassword(
          confirmPassword: confirmPassword, currentPassword: currentPassword, password: password);
    } on Exception catch (e) {
      LogManager.error("changePassword::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? image,
    String? number,
  }) async {
    try {
      return await repository.updateProfile(number: number, image: image, name: name);
    } on Exception catch (e) {
      LogManager.error("updateProfile::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool> updateProfileV1(
      {String? name,
      String? image,
      String? number,
      String? whatsappNumber,
      String? iqamaId,
      String? email,
      String? mobileNumberCountryCode,
      String? whatsappNumberCountryCode,
      String? deviceId,
      String? deviceName}) async {
    try {
      return await repository.updateProfileV1(
        number: number,
        image: image,
        name: name,
        whatsappNumber: whatsappNumber,
        mobileNumberCountryCode: mobileNumberCountryCode,
        whatsappNumberCountryCode: whatsappNumberCountryCode,
        iqamaId: iqamaId,
        email: email,
        deviceId: deviceId,
        deviceName: deviceName,
      );
    } on Exception catch (e) {
      LogManager.error("updateProfileV1::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
