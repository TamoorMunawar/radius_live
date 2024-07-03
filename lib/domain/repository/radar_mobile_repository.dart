import 'package:radar/domain/entities/Job.dart';
import 'package:radar/domain/entities/announcement/Announcement.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard/dashboard_detail.dart';
import 'package:radar/domain/entities/dashboard_attandace_data/Dashboard_attandace_data.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/entities/job_dashboard/job_dashboard.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/entities/login/Login.dart';
import 'package:radar/domain/entities/outside_event_usher/outside_event_usher.dart';
import 'package:radar/domain/entities/profile/profile_model.dart';
import 'package:radar/domain/entities/register/Register.dart';
import 'package:radar/domain/entities/register_payload/Register_payload.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/entities/user_detail/User_detail.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/domain/entities/zone_dashboard/zone_dashboard.dart';

abstract class RadarMobileRepository {
  Future<Login> login(
      {String? email,
      String? lat,
      String? lng,
      String? password,
      String? deviceToken,
      String? deviceId,
      String? deviceName,
      bool? isLoginWithMobile,
      String? countryCode});
  Future<bool?> scanQrCodeForUsherInvite({
    ScanQrCodeUsherInvitePayload? scanQrCodePayload,
    int? zoneId,
    int? jobId,
    String? latitude,
    String? longitude,
    int? eventId,
  });
  Future<bool?> zoneSeats({int? zoneId});
  Future<String> getQrCode({String? latitude, String? longitude});
  Future<bool> appUpdate({String? appVersion});
  Future<List<Ushers>> getUshers({int? zoneId, bool? isZoneSelected, int? page});
  Future<List<OutsideEventUsher>> getUshersByEvent({int? eventId, int? page});
  Future<List<Supervisior>> getSuperVisior();
  Future<DashboardAttandanceData> getAttandanceData({int? userId});
  Future<List<Job>> getJob({int? eventModelId, bool? isZone, int? zoneId});
  Future<List<Zone>> getZoneByUserId({int? eventId});
  Future<bool?> scanQrCodeByEventId({
    ScanQrCodePayload? scanQrCodePayload,
    int? userId,
    bool? isCheckout,
    double? latitude,
    double? longitude,
    int? eventModelId,
    int? zoneId,
  });

  Future<List<Zone>> getZone({int? eventId});

  Future<bool> createZone({
    int? eventId,
    int? supervisiorId,
    String? location,
    int? jobId,
    String? maleMainSeats,
    String? femaleMainSeats,
    String? malestbySeats,
    String? femalestbySeats,
    String? description,
    String? zoneName,
  });

  Future<bool> createAlert({
    String? heading,
    String? to,
    String? departmentId,
    String? description,
  });

  Future<bool> changePassword({
    String? currentPassword,
    String? password,
    String? confirmPassword,
  });
  Future<DashboardDetail> dashboardDetail({int? eventId});
  Future<List<JobDashboard>> dashboardJob({int? eventId});
  Future<List<ZoneDashboard>> dashboardZone({int? eventId});
  Future<ProfileModel> getProfileDetails();
  Future<bool> updateProfile({
    String? name,
    String? image,
    String? number,
  });
  Future<bool> updateProfileV1({
    String? name,
    String? image,
    String? number,
    String? whatsappNumber,
    String? iqamaId,
    String? email,
    String? mobileNumberCountryCode,
    String? whatsappNumberCountryCode,
  });
  Future<List<LatestEventModel>> latestEvent();

  Future<bool> createJob(
      {int? eventId,
      String? jobName,
      String? totalMaleSalary,
      String? totalFemaleSalary,
      String? dailyMaleSalary,
      String? dailyFemaleSalary});

  Future<List<Department>> getDepartment();

  Future<List<InitialEvent>> getInitialEvents({int? page});

  Future<List<InitialEvent>> getFinalEvents({int? page});

  Future<List<Announcement>> getAnnouncement({int? page});

  Future<EventDetail> getEventDetailById({int? eventId});

  Future<bool> acceptInvitation({
    int? eventId,
    int? status,
  });

  Future<bool?> scanQrCode(
      {ScanQrCodePayload? scanQrCodePayload, int? userId, bool? isCheckout, double? latitude, double? longitude});

  Future<int?> forgetPassword({String? email, String? countryCode, bool? isLoginWithMobile});

  Future<bool?> checkOtp({String? email, String? otp, String? countryCode, required bool isLoginWithMobile});

  Future<bool?> sendOtp({String? email, String? number, String? countryCode});

  Future<bool?> resetPassword(
      {String? email,
      int? otp,
      String? password,
      String? confirmPassword,
      String? countryCode,
      required bool isLoginWithMobile});

  Future<Register> register({RegisterPayload? registerPayload, String? documentPath});

  Future<UserDetail> userDetails();

  Future<List<Attandance>> getAttandance();
}
