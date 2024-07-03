import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard_attandace_data/Dashboard_attandace_data.dart';
import 'package:radar/domain/entities/outside_event_usher/outside_event_usher.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class UsherUsecase {
  final RadarMobileRepository repository;

  UsherUsecase({required this.repository});

  Future<List<Ushers>> getUshers({int? zoneId,bool? isZoneSelected,int?page}) async {
    try {
      return await repository.getUshers(zoneId:zoneId,isZoneSelected: isZoneSelected,page:page);
    } on Exception catch (e) {
      LogManager.error("Attandance::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
  Future<List<OutsideEventUsher>> getUshersByEvent({int? eventId,int?page}) async {
    try {
      return await repository.getUshersByEvent(page:page,eventId: eventId);
    } on Exception catch (e) {
      LogManager.error("Attandance::error", e);
      throw Exception(e.toString().substring(11));
    }
  }


}