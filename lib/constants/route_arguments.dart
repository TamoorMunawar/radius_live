import 'package:radar/domain/entities/events/event_detail/Event_zone_all.dart';

import '../domain/entities/ushers/Department.dart';

class OtpScreenRoute {
  final String email;
  final String countryCode;
  final bool isLoginWithMobile;
  int otp;

  OtpScreenRoute({
    required this.isLoginWithMobile,
    required this.email,
    required this.countryCode,
    required this.otp,
  });
}

class VerificationRoute {
  final String email;
  final String countryCode;
  final String number;
  final bool fromLogin;

  VerificationRoute({
    required this.email,
    required this.countryCode,
    required this.number,
    required this.fromLogin,
  });
}

class ResetPasswordScreenRoute {
  final String email;
  final String countryCode;
  final bool isLoginWithMobile;
  final int otp;

  ResetPasswordScreenRoute({
    required this.email,
    required this.otp,
    required this.countryCode,
    required this.isLoginWithMobile,
  });
}

class UsherListByEventScreenRoute {
  final int eventId;

  UsherListByEventScreenRoute({
    required this.eventId,
  });
}

class JobDashboardScreenRoute {
  final int eventId;

  JobDashboardScreenRoute({
    required this.eventId,
  });
}

class ZoneDashboardScreenRoute {
  final int eventId;

  ZoneDashboardScreenRoute({
    required this.eventId,
  });
}

class EventDetailScreenArgs {
  final int eventId;
  final bool finalInvitation;

  EventDetailScreenArgs({
    required this.eventId,
    this.finalInvitation = false,
  });
}

class UsherInviteScreenArgs {
  final int eventId;
  final bool finalInvitation;
  final List<EventZoneAll> eventZoneAll;

  UsherInviteScreenArgs({
    required this.eventId,
    required this.eventZoneAll,
    this.finalInvitation = false,
  });
}

class CreateJobScreenArgs {
  final int id;

  CreateJobScreenArgs({
    required this.id,
  });
}


class EditProfileScreenArgs {
  final bool isFromLogin;
  final String phoneCode;

  EditProfileScreenArgs({
    this.isFromLogin = false,
    required this.phoneCode,
  });
}

class CreateZoneScreenArgs {
  final int eventId;

  // final int jobId;

  CreateZoneScreenArgs({
    //required this.jobId,
    required this.eventId,
  });
}

class ReviewScreenArgs {
  var usherId;
  var depertmentIdd;
  var depertmentName;

  ReviewScreenArgs({
    required this.usherId,
    required this.depertmentIdd,
    required this.depertmentName
  });
}
