import 'package:radar/constants/logger.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class EventListUsecase {
  final RadarMobileRepository repository;

  EventListUsecase({required this.repository});

  Future<List<MyEvent>> getEventList() async {
    try {
      return await repository.getEventList();
    } on Exception catch (e) {
      LogManager.error("getEventList::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
