import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:screenshot/screenshot.dart';

class EventHistory extends StatefulWidget {
  const EventHistory({Key? key}) : super(key: key);

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> {




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
          "Event History".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.02),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05)),
            height: SizeConfig.height(context, 0.07),
            color: GlobalColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Event List'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Event JOB'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Rating'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ],
            ),
          ),
          buildDividerWidget(context: context),

        ],
      ),
    );
  }
}
