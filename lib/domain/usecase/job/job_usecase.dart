import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/Job.dart';

import 'package:radar/domain/repository/radar_mobile_repository.dart';

class JobUsecase {
  final RadarMobileRepository repository;

  JobUsecase({required this.repository});

  Future<List<Job>> getJob({int? eventModelId,bool ?isZone,int?zoneId}) async {
    try {
      return await repository.getJob(eventModelId: eventModelId,zoneId: zoneId,isZone: isZone);
    } on Exception catch (e) {
      LogManager.error("JobUsecase::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
