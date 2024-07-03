import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard_attandace_data/Dashboard_attandace_data.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class AttandanceUsecase {
  final RadarMobileRepository repository;

  AttandanceUsecase({required this.repository});
  Future<List<LatestEventModel>> latestEvents() async {
    try {
      return await repository.latestEvent();
    } on Exception catch (e) {
      LogManager.error("latestEvents::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
  Future<List<Attandance>> getAttandance() async {
    try {
      return await repository.getAttandance();
    } on Exception catch (e) {
      LogManager.error("Attandance::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<DashboardAttandanceData> getAttandaceData({int?userId}) async {
    try {
      return await repository.getAttandanceData(userId:userId);
    } on Exception catch (e) {
      LogManager.error("getAttandaceData::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}