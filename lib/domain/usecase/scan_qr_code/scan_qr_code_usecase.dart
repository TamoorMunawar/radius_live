import 'package:radar/constants/logger.dart';

import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ScanQrCodeUsecase {
  final RadarMobileRepository repository;

  ScanQrCodeUsecase({required this.repository});

  Future<bool?> scanQrCodeByEventId({
    ScanQrCodePayload? scanQrCodePayload,
    int? userId,
    bool? isCheckout,
    double? latitude,
    double? longitude,
    int? eventModelId,
    int? zoneId,
  }) async {
    try {
      return await repository.scanQrCodeByEventId(
        scanQrCodePayload: scanQrCodePayload,
        userId: userId,
        eventModelId: eventModelId,
        zoneId: zoneId,
        isCheckout: isCheckout,
        longitude: longitude,
        latitude: latitude,
      );
    } on Exception catch (e) {
      LogManager.error("scanQrCodeByEventId::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool?> scanQrCodeForUsherInvite({
    ScanQrCodeUsherInvitePayload? scanQrCodePayload,
    int? zoneId,
    int? jobId,
    int? eventId,
    String? latitude,
    String? longitude,
  }) async {
    try {
      return await repository.scanQrCodeForUsherInvite(
          scanQrCodePayload: scanQrCodePayload,
          zoneId: zoneId,
          eventId: eventId,
          jobId: jobId,
          longitude: longitude,
          latitude: latitude);
    } on Exception catch (e) {
      LogManager.error("scanQrCodeForUsherInvite::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<bool?> scanQrCode(
      {double? latitude,
      double? longitude,
      ScanQrCodePayload? scanQrCodePayload,
      int? userId,
      bool? isCheckout}) async {
    try {
      return await repository.scanQrCode(
        scanQrCodePayload: scanQrCodePayload,
        userId: userId,
        isCheckout: isCheckout,
        longitude: longitude,
        latitude: latitude,
      );
    } on Exception catch (e) {
      LogManager.error("scanQrCode::error", e);
      throw Exception(e.toString().substring(11));
    }
  }

  Future<String> getQrCode({String? latitude, String? longitude}) async {
    try {
      return await repository.getQrCode(
          longitude: longitude, latitude: latitude);
    } on Exception catch (e) {
      LogManager.error("getQrCode::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
