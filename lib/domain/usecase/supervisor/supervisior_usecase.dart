import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class SupervisiorUsecase{
  final RadarMobileRepository repository;

  SupervisiorUsecase({required this.repository});

  Future<List<Supervisior>> getSuperVisior(
      ) async {
    try {
      return await repository.getSuperVisior() ;
    } on Exception catch (e) {
      LogManager.error("SupervisiorUsecase::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}