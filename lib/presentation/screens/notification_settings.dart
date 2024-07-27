import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool allFlag = false;
  bool alterFlag = false;
  bool complainFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Notification Settings".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.height(context, 0.04),
            ),
            NotificationSettingButton(
              //    width: SizeConfig.width(context, 0.5),
              onPressed: () async {
                //    Navigator.pushNamed(context, AppRoutes.notificationSettingScreenRoute);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Notification'.tr(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.width(context, 0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                      activeColor: GlobalColors.primaryColor,
                      activeTrackColor: GlobalColors.backgroundColor,
                      inactiveThumbColor: GlobalColors.submitButtonColor,
                      inactiveTrackColor: GlobalColors.backgroundColor,
                      value: allFlag,
                      onChanged: (bool value) {
                        setState(() {
                          allFlag = value;
                        });
                      })
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.height(context, 0.02),
            ),
            NotificationSettingButton(
              //    width: SizeConfig.width(context, 0.5),
              onPressed: () async {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Alter Notification'.tr(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.width(context, 0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                      activeColor: GlobalColors.primaryColor,
                      activeTrackColor: GlobalColors.backgroundColor,
                      inactiveThumbColor: GlobalColors.submitButtonColor,
                      inactiveTrackColor: GlobalColors.backgroundColor,
                      value: alterFlag,
                      onChanged: (bool value) {
                        setState(() {
                          alterFlag = value;
                        });
                      })
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.height(context, 0.02),
            ),
            NotificationSettingButton(
              //    width: SizeConfig.width(context, 0.5),
              onPressed: () async {
                //     Navigator.pushNamed(context, AppRoutes.complainScreenRoute);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Complain to Supervisor'.tr(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.width(context, 0.04),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                      activeColor: GlobalColors.primaryColor,
                      activeTrackColor: GlobalColors.backgroundColor,
                      inactiveThumbColor: GlobalColors.submitButtonColor,
                      inactiveTrackColor: GlobalColors.backgroundColor,
                      value: complainFlag,
                      onChanged: (bool value) {
                        setState(() {
                          complainFlag = value;
                        });
                      })
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.height(context, 0.02),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSettingButton extends StatelessWidget {
  NotificationSettingButton(
      {super.key,
      this.width,
      this.height,
      this.gradientFirstColor,
      this.gradientSecondColor,
      this.borderWidth,
      required this.onPressed,
      required this.child});

  final double? width;
  final double? height;
  final Color? gradientFirstColor;
  final Color? gradientSecondColor;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.height(context, 0.02),
          bottom: SizeConfig.height(context, 0.02),
          left: SizeConfig.width(context, 0.04),
          right: SizeConfig.width(context, 0.04),
        ),
        margin: EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
        width: width ?? SizeConfig.width(context, 0.9),
        height: height ?? SizeConfig.height(context, 0.09),
        decoration: ShapeDecoration(
          color: gradientFirstColor ?? GlobalColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderWidth ?? SizeConfig.width(context, 0.025)),
          ),
        ),
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}
