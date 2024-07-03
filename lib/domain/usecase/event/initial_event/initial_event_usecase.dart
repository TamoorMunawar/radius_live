import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class InitialEventUsecase{
  final RadarMobileRepository repository;

  InitialEventUsecase({required this.repository});

  Future<List<InitialEvent>> getInitialEvent({int?page}
      ) async {
    try {
      return await repository.getInitialEvents( page: page);
    } on Exception catch (e) {
      LogManager.error("getInitialEvent::error", e);
      throw Exception(e.toString().substring(11));
    }
  }  Future<List<InitialEvent>> getFinalEvent({int?page}
      ) async {
    try {
      return await repository.getFinalEvents( page: page);
    } on Exception catch (e) {
      LogManager.error("getFinalEvent::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}