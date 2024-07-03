import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class AcceptInvitationUsecase{
  final RadarMobileRepository repository;

  AcceptInvitationUsecase({required this.repository});
  Future<bool> acceptInvitation({int?eventId,int ?status}
      ) async {
    try {
      return await repository.acceptInvitation( eventId: eventId,status: status);
    } on Exception catch (e) {
      LogManager.error("acceptInvitation::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}