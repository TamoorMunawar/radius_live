import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class DepartmentUsecase{
  final RadarMobileRepository repository;

  DepartmentUsecase({required this.repository});

  Future<List<Department>> getDepartment(
      ) async {
    try {
      return await repository.getDepartment( );
    } on Exception catch (e) {
      LogManager.error("getDepartment::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}