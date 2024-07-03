import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class CreateJobUsecase {
  final RadarMobileRepository repository;

  CreateJobUsecase({required this.repository});

  Future<bool> createJob(
      {int?eventId, String ?jobName, String? totalMaleSalary, String? totalFemaleSalary, String? dailyMaleSalary,  String? dailyFemaleSalary}) async {
    try {
      return await repository.createJob(
          eventId: eventId,
          dailyMaleSalary: dailyMaleSalary,
          dailyFemaleSalary: dailyFemaleSalary,
          jobName: jobName,
          totalFemaleSalary: totalFemaleSalary,
          totalMaleSalary: totalMaleSalary
      );
    } on Exception catch (e) {
      LogManager.error("createJob::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}