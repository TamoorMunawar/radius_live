import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //GlobalColors.backgroundColor,
        centerTitle: true,
        actions: [
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
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05),right:  SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Notification".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(20, (index) {
            return Container(
              height: SizeConfig.height(context, 0.135),
              width: SizeConfig.width(context, 0.9),

              margin: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.02),
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05)),
              decoration: BoxDecoration(
                border: Border.all(color: GlobalColors.textFieldHintColor),
                  color: GlobalColors.backgroundColor,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width(context, 0.02),
                  )),
              padding: EdgeInsets.only(
                top: SizeConfig.height(context, 0.01),
             //   bottom: SizeConfig.height(context, 0.01),
                left: SizeConfig.width(context, 0.02),
                right: SizeConfig.width(context, 0.02),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: SizeConfig.width(context, 0.01)),
                    child: Text("04:09 PM",style: TextStyle(color: GlobalColors.textFieldHintColor),),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/icons/profile_icon.png"),

                      radius: SizeConfig.width(context, 0.055),
                    ),
                    title: Text(
                      "Invite Job",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.width(context, 0.035),
                      ),
                    ),
                    subtitle: Text(
                      "Invite a job from john smith",
                      style: TextStyle(
                        color: GlobalColors.textFieldHintColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.width(context, 0.035),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
