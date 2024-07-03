import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class AttandaceScreen extends StatefulWidget {
  const AttandaceScreen({super.key});

  @override
  State<AttandaceScreen> createState() => _AttandaceScreenState();
}

class _AttandaceScreenState extends State<AttandaceScreen> {
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
     /*   leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),*/
        title: Text(
          "Attandance".tr(),
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
            return EventsDetailTab(
              title: "Event Name",
              subtitle:
                  "Syracuse, Connecticut May 20, 2023 to May 21, 2023 10:00 AM to 10:00 PM",
              imagePath: "assets/icons/Event.png",
            );
          }),
        ),
      ),
    );
  }
}

class EventsDetailTab extends StatelessWidget {
  const EventsDetailTab({
    super.key,
    this.imagePath,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final String? imagePath;
  final String? title;
  final String? subtitle;
final VoidCallback ?onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
     //   height: SizeConfig.height(context, 0.135),
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
          bottom: SizeConfig.height(context, 0.01),
          //   bottom: SizeConfig.height(context, 0.01),
          left: SizeConfig.width(context, 0.02),
          right: SizeConfig.width(context, 0.02),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath ?? ""),
              radius: SizeConfig.width(context, 0.09),
            ),
            SizedBox(
              width: SizeConfig.width(context, 0.03),
            ),
            Container(
           //   height: SizeConfig.height(context, 0.1),
              // color: Colors.red,
              width: SizeConfig.width(context, 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.width(context, 0.035),
                    ),
                  ),
                  Text(
                    subtitle ?? "",
                    maxLines: 3,
                    style: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.width(context, 0.030),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
