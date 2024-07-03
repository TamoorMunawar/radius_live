import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ZoneSeatsUsecase{
  final RadarMobileRepository repository;

  ZoneSeatsUsecase({required this.repository});

  Future<bool?> zoneSeats({int?zoneId}
      ) async {
    try {
      return await repository.zoneSeats(zoneId: zoneId) ;
    } on Exception catch (e) {
      LogManager.error("zoneSeats::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}