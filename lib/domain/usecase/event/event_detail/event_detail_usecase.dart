
import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class EventDetailUsecase{
  final RadarMobileRepository repository;

  EventDetailUsecase({required this.repository});

  Future<EventDetail> getEventDetailById({int?eventId}
      ) async {
    try {
      return await repository.getEventDetailById( eventId: eventId);
    } on Exception catch (e) {
      LogManager.error("getEventDetailById::error", e);
      throw Exception(e.toString().substring(11));
    }
  }


}