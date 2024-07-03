import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/profile/profile_model.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ProfileUsecase{
  final RadarMobileRepository repository;

  ProfileUsecase({required this.repository});
  Future<ProfileModel> getProfileDetail() async {
    try {
      return await repository.getProfileDetails();
    } on Exception catch (e) {
      LogManager.error("getProfileDetail::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}