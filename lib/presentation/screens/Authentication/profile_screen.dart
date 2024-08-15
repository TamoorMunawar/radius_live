import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/extensions.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/main.dart';
import 'package:radar/presentation/cubits/profile/profile_cubit.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isBack = false});
  final bool isBack;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "";
  String name = "";
  late ScanQrCodeCubit scanQrcodeCubit;

  String image = "";
  String? roleName;
  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalColors.backgroundColor,
          title: Text('Delete Account'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.width(context, 0.03),
              )),
          content: Text('Are you sure you want to delete this account?'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.width(context, 0.03),
              )),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.width(context, 0.03),
                  )),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.width(context, 0.03),
                  )),
              onPressed: () async {
                // Add your account deletion logic here
                // Dismiss the dialog
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreenRoute, (route) => false);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleName = prefs.getString(
          "role_name",
        ) ??
        "";
    image = prefs.getString(
          "user_image",
        ) ??
        "";
    name = prefs.getString(
          "user_name",
        ) ??
        "";
    email = prefs.getString(
          "user_email",
        ) ??
        "Someone";
    print("role name profile screen ${roleName}");
    setState(() {});
  }

  @override
  void initState() {
    getUserDetailsFromLocal();
    context.read<ProfileCubit>().getProfileDetails();
    scanQrcodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        /*actions: [
          IconButton(
            onPressed: () {
              //  Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/message_icon.png",
                width: SizeConfig.width(context, 0.05)),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              //  Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(right: SizeConfig.width(context, 0.05)),
              child: Image.asset("assets/icons/notification.png",
                  width: SizeConfig.width(context, 0.05)),
            ),
            color: Colors.white,
          ),
        ],*/
        leading: (widget.isBack)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 0.05.sw,
                  ),
                ),
                color: Colors.white,
              )
            : Container(),
        title: Text(
          "Profile".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: 0.05.sw,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: GlobalColors.backgroundColor,
                        title: Center(
                            child: Text(
                          'Change Language'.tr(),
                          style: const TextStyle(color: Colors.white),
                        )),
                        content: SizedBox(
                          height: 0.15.sh,
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setBool("isEnglish", true);
                                    await (context.setLocale(const Locale('en')));

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('English')),
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool("isEnglish", false);
                                  await (context.setLocale(const Locale('ar')));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('عربي'),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  });
            },
            style: IconButton.styleFrom(
              backgroundColor: GlobalColors.primaryColor,
              maximumSize: Size(0.04.sh, 0.04.sh),
              minimumSize: Size(0.04.sh, 0.04.sh),
            ),
            icon: Icon(
              Symbols.language,
              color: GlobalColors.whiteColor,
              size: 0.02.sh,
            ),
          ),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: GlobalColors.primaryColor,
              maximumSize: Size(0.04.sh, 0.04.sh),
              minimumSize: Size(0.04.sh, 0.04.sh),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editProfileScreenRoute,
                  arguments: EditProfileScreenArgs(isFromLogin: false, phoneCode: "+92"));
            },
            icon: Icon(
              Symbols.stylus,
              color: GlobalColors.whiteColor,
              size: 0.02.sh,
            ),
          ),
          SizedBox(
            width: 0.02.sw,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.01.sh),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (image.contains("http"))
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(image),
                                  //backgroundColor: Colors.red,
                                  radius: 0.11.sw,
                                )
                              : CircleAvatar(
                                  backgroundImage: const AssetImage("assets/icons/profile_icon.png"),
                                  //                backgroundColor: Colors.red,
                                  radius: 0.11.sw,
                                ),
                          Text(
                            name,
                            style: TextStyle(
                              color: GlobalColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 0.04.sw,
                            ),
                          ),
                          Text(
                            state is ProfileSuccess ? state.profileModel.deviceId ?? "" : "",
                            style: TextStyle(
                              color: GlobalColors.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 0.03.sw,
                            ),
                          ),
                          SizedBox(height: 0.01.sh),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sw),
                            decoration:
                                BoxDecoration(color: GlobalColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              state is ProfileSuccess
                                  ? state.profileModel.jobName ?? "Job Not Assigned"
                                  : "Job Not Assigned",
                              style: TextStyle(
                                color: GlobalColors.whiteColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 0.03.sw,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.04.sh,
                          ),
                          const Row(
                            children: [
                              WorkInfoItem(title: "Total Jobs", value: "4"),
                              WorkInfoItem(title: "Total events", value: "80"),
                              WorkInfoItem(title: "ratting", value: "1"),
                              WorkInfoItem(title: "last pay", value: "\$1200"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 0.04.sh),
                Container(
                  //  height: SizeConfig.height(context, 0.2),
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                      color: GlobalColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        0.06.sw,
                      )),
                  padding: EdgeInsets.only(
                    top: 0.03.sh,
                    bottom: 0.03.sh,
                  ),
                  margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileButton(
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          showDeleteConfirmationDialog(context);
                          //   Navigator.pushNamed(context, AppRoutes.qrAttandance);
                        },
                        title: 'Delete Account '.tr(),
                        icon: Symbols.account_circle,
                      ),
                      (roleName == "Client")
                          ? Container()
                          : SizedBox(
                              height: 0.02.sh,
                            ),
                      (roleName == "Client")
                          ? Container()
                          : ProfileButton(
                              //    width: SizeConfig.width(context, 0.5),
                              onPressed: () async {
                                Navigator.pushNamed(context, AppRoutes.qrCodeScreenRoute);
                              },
                              title: 'Qr Code'.tr(), icon: Symbols.qr_code,
                            ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      ProfileButton(
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.notificationSettingScreenRoute);
                        },
                        title: 'Notification Settings'.tr(),
                        icon: Symbols.settings,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      ProfileButton(
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.changePasswordScreenRoute);
                        },
                        title: 'Change Password'.tr(), icon: Symbols.lock,
                      ),
                      SizedBox(height: SizeConfig.height(context, 0.02)),
                      ProfileButton(
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.complainScreenRoute);
                        },
                        title: 'Logistics'.tr(),
                        icon: Symbols.report,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      ProfileButton(
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.updateGroupScreenRoute);
                        },
                        title: 'Update Group'.tr(),
                        icon: Symbols.local_activity,
                      ),
                      SizedBox(height: SizeConfig.height(context, 0.02)),
                      ProfileButton(
                        gradientFirstColor: GlobalColors.logoutColor,
                        //    width: SizeConfig.width(context, 0.5),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("qr_code");
                          prefs.clear();
                          prefs.setBool("isLocationDailog", true);
                          socket.disconnect();
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreenRoute, (route) => false);
                        },
                        title: 'Logout'.tr(), icon: Symbols.logout,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            BlocConsumer<ScanQrCodeCubit, ScanQrCodeState>(builder: (context, state) {
              if (state is ScanQrcodeLoading) {
                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 0.6.sh,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is ScanQrcodeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
              if (state is ScanQrcodeSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Attandance Marked SuccessFully".tr()),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class WorkInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const WorkInfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: GlobalColors.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 0.03.sw,
            ),
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          Text(
            value,
            style: TextStyle(
              color: GlobalColors.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 0.03.sw,
            ),
          ),
        ],
      ),
    );
  }
}
