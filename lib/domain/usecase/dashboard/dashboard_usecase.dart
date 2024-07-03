import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard/dashboard_detail.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/entities/job_dashboard/job_dashboard.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/entities/zone_dashboard/zone_dashboard.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class DashboardUsecase {
  final RadarMobileRepository repository;

  DashboardUsecase({required this.repository});

  Future<DashboardDetail> dashboardDetail({int?eventId}) async {
    try {
      return await repository.dashboardDetail(eventId: eventId);
    } on Exception catch (e) {
      LogManager.error("dashboardDetail::error", e);
      throw Exception(e.toString().substring(11));
    }
  }


  Future<List<JobDashboard>> dashboardJob({int? eventId}) async {
    try {
      return await repository.dashboardJob(eventId: eventId);
    } on Exception catch (e) {
      LogManager.error("dashboardJob::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
  Future<List<ZoneDashboard>> dashboardZone({int? eventId}) async {
    try {
      return await repository.dashboardZone(eventId: eventId);
    } on Exception catch (e) {
      LogManager.error("dashboardZone::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
