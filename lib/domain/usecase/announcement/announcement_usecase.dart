import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/announcement/Announcement.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class AnnouncementUsecase{
  final RadarMobileRepository repository;

  AnnouncementUsecase({required this.repository});

  Future<List<Announcement>> getAnnouncement(
      {int ?page}
      ) async {
    try {
      return await repository.getAnnouncement(page: page);
    } on Exception catch (e) {
      LogManager.error("getAnnouncement::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

}