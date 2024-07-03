import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class CreateZoneUsecase {
  final RadarMobileRepository repository;

  CreateZoneUsecase({required this.repository});

  Future<bool> createZone({
    int? eventId,
    int? supervisiorId,
    String? location,
    int? jobId,
    String? maleMainSeats,
    String? femaleMainSeats,
    String? malestbySeats,
    String? femalestbySeats,
    String? description,
    String? zoneName,
  }) async {
    try {
      return await repository.createZone(
        eventId: eventId,
        description: description,
        femaleMainSeats: femaleMainSeats,
        femalestbySeats: femalestbySeats,
        jobId: jobId,
        location: location,
        maleMainSeats: maleMainSeats,
        malestbySeats: malestbySeats,
        supervisiorId: supervisiorId,
        zoneName: zoneName,
      );
    } on Exception catch (e) {
      LogManager.error("createZone::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
