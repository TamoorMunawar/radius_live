import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/usecase/scan_qr_code/scan_qr_code_usecase.dart';

part 'scan_qrcode_state.dart';

class ScanQrCodeCubit extends Cubit<ScanQrCodeState> {
  final ScanQrCodeUsecase usecase;

  ScanQrCodeCubit(this.usecase) : super(ScanQrcodeInitial());

  void scanQrCodeByEventId(
      {ScanQrCodePayload? scanQrCodePayload,
      int? userId,
      bool? isCheckout,
      int? eventModelId,
      int? zoneId,
      double? latitude,
      double? longitude}) async {
    try {
      emit(ScanQrcodeLoading());
      bool? result = await usecase.scanQrCodeByEventId(
          scanQrCodePayload: scanQrCodePayload,
          userId: userId,
          eventModelId: eventModelId,
          zoneId: zoneId,
          isCheckout: isCheckout,
          latitude: latitude,
          longitude: longitude);
      emit(ScanQrcodeSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ScanQrcodeFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void usherCheckIn({int? eventId, double? latitude, double? longitude, var zoneId}) async {
    try {
      emit(UsherAttendanceLoading());
      bool result =
          await usecase.usherCheckIn(eventId: eventId, latitude: latitude, longitude: longitude, zoneId: zoneId);
      emit(UsherCheckinSuccess(success: result));
    } on Exception catch (e) {
      emit(
        UsherAttendanceFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void usherCheckout() async {
    try {
      emit(UsherAttendanceLoading());
      final attendance = await usecase.getToday();
      if (attendance != null) {
        bool result = await usecase.usherCheckout(attendance.$1);
        emit(UsherCheckoutSuccess(success: result));
      } else {
        emit(const UsherAttendanceFailure(errorMessage: "You are not checked in!"));
      }
    } on Exception catch (e) {
      emit(
        UsherAttendanceFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getQrCode({String? latitude, String? longitude}) async {
    try {
      emit(ScanQrcodeLoading());
      String? result = await usecase.getQrCode(latitude: latitude, longitude: longitude);
      emit(GetQrcodeSuccess(qrCode: result));
    } on Exception catch (e) {
      print("inside qr code failure state");
      emit(
        ScanQrcodeFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void scanQrCode(
      {ScanQrCodePayload? scanQrCodePayload,
      int? userId,
      bool? isCheckout,
      double? latitude,
      double? longitude}) async {
    try {
      emit(ScanQrcodeLoading());
      bool? result = await usecase.scanQrCode(
          scanQrCodePayload: scanQrCodePayload,
          userId: userId,
          isCheckout: isCheckout,
          latitude: latitude,
          longitude: longitude);
      emit(ScanQrcodeSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ScanQrcodeFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void scanQrCodeForUsherInvite({
    ScanQrCodeUsherInvitePayload? scanQrCodePayload,
    int? zoneId,
    int? jobId,
    int? eventId,
    String? latitude,
    String? longitude,
  }) async {
    try {
      emit(ScanQrcodeForUsherInviteLoading());
      bool? result = await usecase.scanQrCodeForUsherInvite(
          scanQrCodePayload: scanQrCodePayload,
          jobId: jobId,
          eventId: eventId,
          zoneId: zoneId,
          latitude: latitude,
          longitude: longitude);
      emit(ScanQrcodeForUsherInviteSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ScanQrcodeForUsherInviteFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
