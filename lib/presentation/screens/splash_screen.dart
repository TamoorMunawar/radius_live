import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/notification_service.dart';
import 'package:radar/presentation/cubits/login/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isProfile});

  final bool isProfile;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token = "";

  late LoginCubit loginCubit;
  NotificationServices notificationServices = NotificationServices();

  bool appUpdate = false;

  bool isProfileUpdated = false;

  Future<void> checkAppVersion() async {
    // Get the current installed app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;

    print("Current app version is: $currentVersion");
    loginCubit.appUpdate(appVersion: currentVersion);
    // Here you can add logic to compare this version with the one fetched from the Play Store
  }

  String appUpdateUrl = (Platform.isAndroid)
      ?  '1.0.46'
      : "https://apps.apple.com/us/app/radius-live/id6618153542";
  String? currentVersion = "";

  void checkLocationServiceStatus() async {
    var location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    print("Location status splash screen $serviceEnabled");
    print("Location status splash screen ${location.hasPermission}");
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle if the user denies turning on the location service.
      }
    }
  }

  @override
  void initState() {
    checkAppVersion();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.foregroundMessage();
    notificationServices.getToken().then((value) {
      print("device token $value");
    });

    super.initState();
  }

  Future<void> _loadData() async {
    var location = Location();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnglish = prefs.getBool("isEnglish") ?? true;
    await (isEnglish
        ? context.setLocale(const Locale('en'))
        : context.setLocale(Locale('ar')));
    token = prefs.getString("token") ?? "";
    isProfileUpdated = prefs.getBool("isProfileUpdated") ?? false;
    PermissionStatus permissionStatus = await location.hasPermission();
    print("permission status ${permissionStatus.name}");
    print("token aaa $token");
    print("isEnglish aaa $isEnglish");
    var status = await ph.Permission.location.status;
    print("splash location status $status");
    setState(() {});
    await Future.delayed(
      const Duration(seconds: 3),
    );
    print("user token $token");
    print("isProfileUpdated $isProfileUpdated");
    print("appUpdate $appUpdate");

    if (appUpdate) {

      if (permissionStatus.name != "granted") {
        print("indie 11");
        prefs.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreenRoute,
              (route) => false,
        );
      } else if (token != null && token != "" && isProfileUpdated) {
        print("indie 22");
        if (widget.isProfile) {
          Navigator.pushNamed(context, AppRoutes.editProfileScreenRoute,
              arguments:
              EditProfileScreenArgs(isFromLogin: true, phoneCode: "+92"));
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.pagesScreenRoute,
                (route) => false,
            arguments: 0,
          );
        }
      } else {
        print("indie 33");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginScreenRoute,
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GlobalColors.backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.15),
                  right: SizeConfig.width(context, 0.15),
                ),
                child: Image.asset(
                  "assets/icons/logo_with_name.png",
                ),
              ),
            ),
            BlocConsumer<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is AppUpdateSuccess) {
                    return Container(
                      height: 0,
                    );
                  }

                  if (state is LoginFailed) {
                    return AlertDialog(
                      backgroundColor: GlobalColors.backgroundColor,
                      title: Text(
                        "App_Update".tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        "${"Update_App_From".tr()} ${(Platform.isAndroid) ? "Play Store." : "App Store."}${"Your app current version is".tr()} $currentVersion",
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            print(appUpdateUrl);
                            appUpdateLauncher(appUpdateUrl);
                          },
                          child: Text(
                            "Update".tr(),
                            style: TextStyle(
                                color: GlobalColors.whiteColor,
                                fontSize: SizeConfig.width(context, 0.05)),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }, listener: (context, state) {
              print("appUpdate $appUpdate");
              if (state is AppUpdateSuccess) {
                setState(() {
                  appUpdate = true;
                });
                _loadData();
              }
              if (state is LoginFailed) {
                AppUtils.showFlushBar(state.errorMessage, context);
                if(mounted){

                  setState(() {
                    appUpdate = false;
                  });
                }
              }
            }),
          ],
        ),
      ),
    );
  }

  Future appUpdateLauncher(String appUpdateUrl) async {
    if (await canLaunchUrl(Uri.parse(appUpdateUrl))) {
      await launchUrl(
        Uri.parse(appUpdateUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}

