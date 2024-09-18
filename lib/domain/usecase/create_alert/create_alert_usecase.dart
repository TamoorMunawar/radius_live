import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class CreateAlertUsecase {
  final RadarMobileRepository repository;

  CreateAlertUsecase({required this.repository});

  Future<bool> createAlert({
    // String? heading,
    // String? to,
    // String? departmentId,
    // String? description,
    int? eventId,
    String? type,
    String? message,
  }) async {
    try {
      return await repository.createAlert(
        eventId: eventId,
        message: message,
        type: type,
        // description: description,
        // departmentId: departmentId,
        // heading: heading,
        // to: to,
      );
    } on Exception catch (e) {
      LogManager.error("createAlert::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
