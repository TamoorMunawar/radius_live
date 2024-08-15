part of 'scan_qrcode_cubit.dart';

abstract class ScanQrCodeState extends Equatable {
  const ScanQrCodeState();
}

class ScanQrcodeInitial extends ScanQrCodeState {
  @override
  List<Object> get props => [];
}

class ScanQrcodeLoading extends ScanQrCodeState {
  @override
  List<Object> get props => [];
}

class ScanQrcodeSuccess extends ScanQrCodeState {
  final bool? result;

  ScanQrcodeSuccess({required this.result});
  @override
  List<Object> get props => [];
}

class GetQrcodeSuccess extends ScanQrCodeState {
  final String? qrCode;

  const GetQrcodeSuccess({required this.qrCode});
  @override
  List<Object> get props => [];
}

class ScanQrcodeFailure extends ScanQrCodeState {
  final String errorMessage;

  const ScanQrcodeFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class ScanQrcodeForUsherInviteLoading extends ScanQrCodeState {
  @override
  List<Object> get props => [];
}

class ScanQrcodeForUsherInviteSuccess extends ScanQrCodeState {
  final bool? result;

  ScanQrcodeForUsherInviteSuccess({required this.result});
  @override
  List<Object> get props => [];
}

class ScanQrcodeForUsherInviteFailure extends ScanQrCodeState {
  final String errorMessage;

  const ScanQrcodeForUsherInviteFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class UsherAttendanceLoading extends ScanQrCodeState {
  @override
  List<Object> get props => [];
}

class UsherCheckinSuccess extends ScanQrCodeState {
  final bool success;
  const UsherCheckinSuccess({required this.success});
  @override
  List<Object> get props => [];
}

class UsherCheckoutSuccess extends ScanQrCodeState {
  final bool success;
  const UsherCheckoutSuccess({required this.success});
  @override
  List<Object> get props => [];
}

class UsherAttendanceFailure extends ScanQrCodeState {
  final String errorMessage;
  const UsherAttendanceFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
