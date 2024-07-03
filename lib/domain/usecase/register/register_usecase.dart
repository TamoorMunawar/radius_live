import 'package:radar/constants/logger.dart';

import 'package:radar/domain/entities/register/Register.dart';
import 'package:radar/domain/entities/register_payload/Register_payload.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class RegisterUsecase{
  final RadarMobileRepository repository;

  RegisterUsecase({required this.repository});

  Future<Register> register(
      {RegisterPayload ?registerPayload,String?documentPath}) async {
    try {
      return await repository.register( registerPayload: registerPayload,documentPath:documentPath);
    } on Exception catch (e) {
      LogManager.error("register::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}