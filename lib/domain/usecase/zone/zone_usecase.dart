import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ZoneUsecase{
  final RadarMobileRepository repository;

  ZoneUsecase({required this.repository});

  Future<List<Zone>> getZone({int?eventId}
      ) async {
    try {
      return await repository.getZone(eventId: eventId) ;
    } on Exception catch (e) {
      LogManager.error("getZone::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
  Future<List<Zone>> getZoneByUserId({int?eventId}
      ) async {
    try {
      return await repository.getZoneByUserId(eventId: eventId) ;
    } on Exception catch (e) {
      LogManager.error("getZoneByUserId::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}