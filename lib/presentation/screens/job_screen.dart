import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/screens/event_detail.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
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
      /*  leading: IconButton(
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
          "Jobs".tr(),
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
            return InkWell(onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetilsScreen()));
            },
              child: Container(
                //height: SizeConfig.height(context, 0.155),
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
                  top: SizeConfig.height(context, 0.02),
                  bottom: SizeConfig.height(context, 0.02),
                  //   bottom: SizeConfig.height(context, 0.01),
                  left: SizeConfig.width(context, 0.04),
                  right: SizeConfig.width(context, 0.04),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Guard",
                          style: TextStyle(
                              fontSize: SizeConfig.width(context, 0.035),
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "\$90 per hr",
                          style: TextStyle(
                              fontSize: SizeConfig.width(context, 0.035),
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Text(
                      "Event Name",
                      style: TextStyle(
                          fontSize: SizeConfig.width(context, 0.035),
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.textFieldHintColor),
                    ),
                    Container(  width: SizeConfig.width(context, 0.5),//color: Colors.red,
                      child: Text(
                        "May 20, 2023 to May 21, 2023 10:00 AM to 10:00 PM",
                        maxLines: 2,style: TextStyle(

                            fontSize: SizeConfig.width(context, 0.035),
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.45)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
