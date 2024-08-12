import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/data/radar_mobile_repository_impl.dart';
import 'package:radar/domain/entities/announcement/Announcement.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/usecase/accept_invitation/accept_ivitation_usecase.dart';
import 'package:radar/domain/usecase/announcement/announcement_usecase.dart';
import 'package:radar/domain/usecase/attandance_usecase.dart';
import 'package:radar/domain/usecase/change_password/change_password_usecase.dart';
import 'package:radar/domain/usecase/create_alert/create_alert_usecase.dart';
import 'package:radar/domain/usecase/create_job/create_job_usecase.dart';
import 'package:radar/domain/usecase/create_zone/create_zone_usecase.dart';
import 'package:radar/domain/usecase/dashboard/dashboard_usecase.dart';
import 'package:radar/domain/usecase/department/department_usecase.dart';
import 'package:radar/domain/usecase/event/event_detail/event_detail_usecase.dart';
import 'package:radar/domain/usecase/event/initial_event/initial_event_usecase.dart';
import 'package:radar/domain/usecase/forgot_password/forgot_password_usecase.dart';
import 'package:radar/domain/usecase/job/job_usecase.dart';
import 'package:radar/domain/usecase/login/login_usecase.dart';
import 'package:radar/domain/usecase/profile/profile_usecase.dart';
import 'package:radar/domain/usecase/register/register_usecase.dart';
import 'package:radar/domain/usecase/review/review_usecase.dart';
import 'package:radar/domain/usecase/scan_qr_code/scan_qr_code_usecase.dart';
import 'package:radar/domain/usecase/supervisor/supervisior_usecase.dart';
import 'package:radar/domain/usecase/ushers/usher_usecase.dart';
import 'package:radar/domain/usecase/verification/verification_usecase.dart';
import 'package:radar/domain/usecase/zone/zone_usecase.dart';
import 'package:radar/domain/usecase/zone_seats/zone_seats_usecase.dart';
import 'package:radar/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:radar/presentation/cubits/events/event_detail/timer_cubit.dart';
import 'package:radar/presentation/cubits/profile/profile_cubit.dart';
import 'package:radar/presentation/cubits/review/review_cubit.dart';
import 'package:radar/presentation/cubits/verification/verification_cubit.dart';
import 'package:radar/presentation/cubits/zone_seats/zone_seats_cubit.dart';
import 'package:radar/presentation/screens/dashboard/admin_dashboard_screen.dart';
import 'package:radar/presentation/screens/event_detail_screen.dart';
import 'package:radar/presentation/cubits/accept_Invitation/accept_invitation_cubit.dart';
import 'package:radar/presentation/cubits/announcement/announcement_cubit.dart';
import 'package:radar/presentation/cubits/attandance/attandance_cubit.dart';
import 'package:radar/presentation/cubits/change_password/change_password_cubit.dart';
import 'package:radar/presentation/cubits/create_alert/create_alert_cubit.dart';
import 'package:radar/presentation/cubits/create_zone/create_zone_cubit.dart';
import 'package:radar/presentation/cubits/department/department_cubit.dart';
import 'package:radar/presentation/cubits/events/create_job/create_job_cubit.dart';
import 'package:radar/presentation/cubits/events/event_detail/event_detail_cubit.dart';
import 'package:radar/presentation/cubits/events/initial_events/initial_event_cubit.dart';
import 'package:radar/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:radar/presentation/cubits/jobs/job_cubit.dart';
import 'package:radar/presentation/cubits/login/login_cubit.dart';
import 'package:radar/presentation/cubits/register/register_cubit.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/cubits/supervisior/supervisior_cubit.dart';
import 'package:radar/presentation/cubits/ushers/usher_cubit.dart';
import 'package:radar/presentation/cubits/zone/zone_cubit.dart';
import 'package:radar/presentation/screens/Authentication/Login.dart';
import 'package:radar/presentation/screens/Authentication/change_password.dart';
import 'package:radar/presentation/screens/Authentication/logistic_screen.dart';
import 'package:radar/presentation/screens/Authentication/edit_profile.dart';
import 'package:radar/presentation/screens/Authentication/forgot_password.dart';
import 'package:radar/presentation/screens/Authentication/profile_screen.dart';

import 'package:radar/presentation/screens/Authentication/reset_password.dart';
import 'package:radar/presentation/screens/Authentication/otp_screen.dart';
import 'package:radar/presentation/screens/announcement.dart';
import 'package:radar/presentation/screens/attandaceDetailScreen.dart';
import 'package:radar/presentation/screens/attandance.dart';
import 'package:radar/presentation/screens/create_job_screen.dart';
import 'package:radar/presentation/screens/create_zone_screen.dart';
import 'package:radar/presentation/screens/dashboard_screen.dart';
import 'package:radar/presentation/screens/events.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/screens/notification.dart';
import 'package:radar/presentation/screens/notification_settings.dart';
import 'package:radar/presentation/screens/pages.dart';
import 'package:radar/presentation/screens/qr_attandance.dart';
import 'package:radar/presentation/screens/qr_code_screen.dart';
import 'package:radar/presentation/screens/review_screen.dart';
import 'package:radar/presentation/screens/splash_screen.dart';
import 'package:radar/presentation/screens/usher_list_by_event.dart';
import 'package:radar/presentation/screens/usher_list_screen.dart';
import 'package:radar/presentation/screens/scan_qr_code_for_usher_invite.dart';
import 'package:radar/presentation/screens/zone_dashboard_screen.dart';

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.loginScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => _login(),
    );
  }
  // if (settings.name == AppRoutes.verification) {
  //   final args = settings.arguments as VerificationRoute;
  //   return MaterialPageRoute(
  //     builder: (context) => _verification(
  //         email: args.email, countryCode: args.countryCode, number: args.number, fromLogin: args.fromLogin),
  //   );
  // }
  if (settings.name == AppRoutes.usherListScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => usherListScreen(),
    );
  }
  if (settings.name == AppRoutes.usherListByEventScreenRoute) {
    final args = settings.arguments as UsherListByEventScreenRoute;
    return MaterialPageRoute(
      builder: (context) => usherListScreenByEvent(eventId: args.eventId),
    );
  }
  if (settings.name == AppRoutes.notificationScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => NotificationScreen(),
    );
  }
  if (settings.name == AppRoutes.forgotScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => _forgotPassword(),
    );
  }
  if (settings.name == AppRoutes.resetScreenRoute) {
    final args = settings.arguments as ResetPasswordScreenRoute;
    return MaterialPageRoute(
      builder: (context) => _resetPassword(
          email: args.email, otp: args.otp, countryCode: args.countryCode, isLoginWithMobile: args.isLoginWithMobile),
    );
  }
  if (settings.name == AppRoutes.otpScreenRoute) {
    final args = settings.arguments as OtpScreenRoute;
    return MaterialPageRoute(
      builder: (context) => _otpScreen(
          email: args.email, otp: args.otp, countryCode: args.countryCode, isLoginWithMobile: args.isLoginWithMobile),
    );
  }
  if (settings.name == AppRoutes.complainScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => const ComplainScreen(),
    );
  }
  if (settings.name == AppRoutes.changePasswordScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => _changePassword(),
    );
  }
  if (settings.name == AppRoutes.editProfileScreenRoute) {
    final args = settings.arguments as EditProfileScreenArgs;
    return MaterialPageRoute(
      builder: (context) => editProfile(isBack: false, isFromLogin: args.isFromLogin, phoneCode: args.phoneCode),
    );
  }
  if (settings.name == AppRoutes.notificationSettingScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => const NotificationSettingScreen(),
    );
  }
  if (settings.name == AppRoutes.pagesScreenRoute) {
    //  final args = settings.arguments as JobDashboardScreenRoute;
    return MaterialPageRoute(
      builder: (context) => PagesWidget(
        currentTab: 0,
        currentPage: dashBoard(),
      ),
    );
  }
  if (settings.name == AppRoutes.attandanceScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => const AttandaceScreen(),
    );
  }
  if (settings.name == AppRoutes.eventScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => eventScreen(),
    );
  }
  if (settings.name == AppRoutes.dashboardJob) {
    final args = settings.arguments as JobDashboardScreenRoute;
    return MaterialPageRoute(
      builder: (context) => dashBoardJob(eventId: args.eventId),
    );
  }
  if (settings.name == AppRoutes.dashboardZone) {
    final args = settings.arguments as ZoneDashboardScreenRoute;
    return MaterialPageRoute(
      builder: (context) => dashBoardZone(eventId: args.eventId),
    );
  }
  if (settings.name == AppRoutes.eventDetailScreenRoute) {
    final args = settings.arguments as EventDetailScreenArgs;
    return MaterialPageRoute(
      builder: (context) => eventDetailScreen(args: args),
    );
  }
  if (settings.name == AppRoutes.scanQrcodeForUsherInviteScreenRoute) {
    final args = settings.arguments as UsherInviteScreenArgs;
    return MaterialPageRoute(
      builder: (context) => scanQrcodeForUsherInviteScreen(args: args),
    );
  }
  if (settings.name == AppRoutes.createJobScreenRoute) {
    final args = settings.arguments as CreateJobScreenArgs;
    return MaterialPageRoute(
      builder: (context) => createJobScreen(args: args),
    );
  }
  if (settings.name == AppRoutes.createZoneScreenRoute) {
    final args = settings.arguments as CreateZoneScreenArgs;
    return MaterialPageRoute(
      builder: (context) => createZoneScreen(args: args),
    );
  }
  if (settings.name == AppRoutes.qrAttandance) {
    return MaterialPageRoute(
      builder: (context) => qrAttandance(),
    );
  }
  if (settings.name == AppRoutes.attandanceDetailScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => attandanceDetails(true),
    );
  }
  if (settings.name == AppRoutes.announcementScreen) {
    return MaterialPageRoute(
      builder: (context) => announcement(hideBackButton: false),
    );
  }
  if (settings.name == AppRoutes.qrCodeScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => qrCodeScreen(),
    );
  }
  if (settings.name == AppRoutes.profileScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => profileScreen(isBack: true),
    );
  }
  if (settings.name == AppRoutes.dashboardScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => dashBoard(),
    );
  }
  if (settings.name == AppRoutes.adminDashboardScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => adminDashBoard(),
    );
  }
  if (settings.name == AppRoutes.addReviewScreenRoute) {
    final args = settings.arguments as ReviewScreenArgs;

    return MaterialPageRoute(
      builder: (context) => reviewScreen(args),
    );
  }
  /*if (settings.name == AppRoutes.scanQrCodeScreenRoute) {
    return MaterialPageRoute(
      builder: (context) => const ScanQrCode(),
    );
  }*/
}

MultiBlocProvider attandanceDetails(bool isBack) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttandanceCubit(AttandanceUsecase(repository: repository)),
        ),
      ],
      child: AttandaceDetailScreen(
        isBack: isBack,
      ));
}

MultiBlocProvider qrCodeScreen() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ScanQrCodeCubit(ScanQrCodeUsecase(repository: repository)),
    ),
  ], child: const QrCodeScreen());
}

MultiBlocProvider eventScreen() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => InitialEventCubit(InitialEventUsecase(repository: repository)),
    ),
  ], child: EventsScreen());
}

MultiBlocProvider eventDetailScreen({required EventDetailScreenArgs args}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TimerCubit(),
        ),
        BlocProvider(
          create: (context) => EventDetailCubit(EventDetailUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => ScanQrCodeCubit(ScanQrCodeUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => AcceptInvitationCubit(AcceptInvitationUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => ZoneCubit(ZoneUsecase(repository: repository)),
        ),
      ],
      child: EventDetilsScreen(
        args: args,
      ));
}

MultiBlocProvider scanQrcodeForUsherInviteScreen({required UsherInviteScreenArgs args}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventDetailCubit(EventDetailUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => ZoneSeatsCubit(ZoneSeatsUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => ScanQrCodeCubit(ScanQrCodeUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => AcceptInvitationCubit(AcceptInvitationUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => ZoneCubit(ZoneUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => JobCubit(JobUsecase(repository: repository)),
        ),
      ],
      child: ScanQrCodeForUsherInvite(
        args: args,
      ));
}

MultiBlocProvider createJobScreen({required CreateJobScreenArgs args}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateJobCubit(CreateJobUsecase(repository: repository)),
        ),
      ],
      child: CreateJobScreen(
        args: args,
      ));
}

MultiBlocProvider createZoneScreen({required CreateZoneScreenArgs args}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SupervisiorCubit(SupervisiorUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => JobCubit(JobUsecase(repository: repository)),
        ),
        BlocProvider(
          create: (context) => CreateZoneCubit(CreateZoneUsecase(repository: repository)),
        ),
      ],
      child: CreateZoneScreen(
        args: args,
      ));
}

MultiBlocProvider announcement({required bool hideBackButton}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnnouncementCubit(AnnouncementUsecase(repository: repository)),
        ),
      ],
      child: AnnouncementScreen(
        hideBackButton: hideBackButton,
      ));
}

MultiBlocProvider _login() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => LoginCubit(LoginUsecase(repository: repository)),
    ),
    BlocProvider(
      create: (context) => RegisterCubit(RegisterUsecase(repository: repository)),
    ),
    BlocProvider(
      create: (context) => DepartmentCubit(
        DepartmentUsecase(
          repository: repository,
        ),
      ),
    ),
  ], child: Login());
}

// MultiBlocProvider _verification(
//     {required String email, required String countryCode, required String number, required bool fromLogin}) {
//   return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => VerificationCubit(VerificationUsecase(repository: repository)),
//         ),
//       ],
//       child: VerificationScreen(
//         email: email,
//         countryCode: countryCode,
//         number: number,
//         fromLogin: fromLogin,
//       ));
// }

MultiBlocProvider _changePassword() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ChangePasswordCubit(ChangePasswordUsecase(repository: repository)),
    ),
  ], child: const ChangePasswordScreen());
}

MultiBlocProvider dashBoard() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AttandanceCubit(
        AttandanceUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => DepartmentCubit(
        DepartmentUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => CreateAlertCubit(
        CreateAlertUsecase(
          repository: repository,
        ),
      ),
    ),
  ], child: DashBoardScreen());
}

MultiBlocProvider adminDashBoard() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AttandanceCubit(
        AttandanceUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => DepartmentCubit(
        DepartmentUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => DashboardCubit(
        DashboardUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => CreateAlertCubit(
        CreateAlertUsecase(
          repository: repository,
        ),
      ),
    ),
  ], child: const AdminDashBoardScreen());
}

MultiBlocProvider dashBoardJob({int? eventId}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttandanceCubit(
            AttandanceUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DepartmentCubit(
            DepartmentUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(
            DashboardUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CreateAlertCubit(
            CreateAlertUsecase(
              repository: repository,
            ),
          ),
        ),
      ],
      child: JobDashBoardScreen(
        eventId: eventId,
      ));
}

MultiBlocProvider dashBoardZone({int? eventId}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AttandanceCubit(
            AttandanceUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DepartmentCubit(
            DepartmentUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(
            DashboardUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CreateAlertCubit(
            CreateAlertUsecase(
              repository: repository,
            ),
          ),
        ),
      ],
      child: ZoneDashBoardScreen(
        eventId: eventId ?? 0,
      ));
}

MultiBlocProvider usherListScreenByEvent({int? eventId}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsherCubit(
            UsherUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ZoneCubit(
            ZoneUsecase(
              repository: repository,
            ),
          ),
        ),
      ],
      child: UsherListByEventScreen(
        eventId: eventId ?? 0,
      ));
}

MultiBlocProvider usherListScreen() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => UsherCubit(
        UsherUsecase(
          repository: repository,
        ),
      ),
    ),
    BlocProvider(
      create: (context) => ZoneCubit(
        ZoneUsecase(
          repository: repository,
        ),
      ),
    ),
  ], child: UsherListScreen());
}

MultiBlocProvider editProfile({required bool isBack, required bool isFromLogin, required String phoneCode}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(
            ProfileUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => VerificationCubit(
            VerificationUsecase(
              repository: repository,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(
            ChangePasswordUsecase(
              repository: repository,
            ),
          ),
        ),
      ],
      child: EditProfileScreen(
        isFromLogin: isFromLogin,
        isBack: false,
        phoneCode: phoneCode,
      ));
}

MultiBlocProvider _forgotPassword() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ForgotPasswordCubit(
        ForgotPasswordUsecase(repository: repository),
      ),
    ),
  ], child: ForgotPassword());
}

MultiBlocProvider splashScreen({required bool isProfile}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            LoginUsecase(repository: repository),
          ),
        ),
      ],
      child: SplashScreen(
        isProfile: isProfile,
      ));
}

MultiBlocProvider qrAttandance() {
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ScanQrCodeCubit(
        ScanQrCodeUsecase(repository: repository),
      ),
    ),
    BlocProvider(
      create: (context) => ZoneSeatsCubit(
        ZoneSeatsUsecase(repository: repository),
      ),
    ),
    BlocProvider(
      create: (context) => ZoneCubit(
        ZoneUsecase(repository: repository),
      ),
    ),
    BlocProvider(
      create: (context) => InitialEventCubit(
        InitialEventUsecase(repository: repository),
      ),
    ),
  ], child: QrAttandanceScreen());
}

MultiBlocProvider _otpScreen({required String email, int? otp, String? countryCode, bool? isLoginWithMobile}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForgotPasswordCubit(ForgotPasswordUsecase(repository: repository)),
        ),
      ],
      child: OTPScreen(
        email: email,
        countryCode: countryCode ?? "",
        isLoginWithMobile: isLoginWithMobile ?? false,
        otp: otp ?? 000000,
      ));
}

MultiBlocProvider _resetPassword(
    {required String email, required String countryCode, required bool isLoginWithMobile, required int otp}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForgotPasswordCubit(ForgotPasswordUsecase(repository: repository)),
        ),
      ],
      child: ResetPassword(
        email: email,
        otp: otp,
        isLoginWithMobile: isLoginWithMobile,
        countryCode: countryCode,
      ));
}

MultiBlocProvider profileScreen({required bool isBack}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ScanQrCodeCubit(ScanQrCodeUsecase(repository: repository)),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(ProfileUsecase(repository: repository)),
      )
    ],
    child: ProfileScreen(isBack: isBack),
  );
}

MultiBlocProvider reviewScreen(ReviewScreenArgs args) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ReviewCubit(ReviewUsecase(repository: repository)),
      ),
    ],
    child: ReviewScreen(
      usherId: args.usherId,
      department: args.department,
    ),
  );
}

var repository = RadarMobileRepositoryImpl();
