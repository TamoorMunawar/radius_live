import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/attandance/attandance_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'attandance.dart';

class AttandaceDetailScreen extends StatefulWidget {
  const AttandaceDetailScreen({super.key, required this.isBack});

  final bool isBack;

  @override
  State<AttandaceDetailScreen> createState() => _AttandaceDetailScreenState();
}

class _AttandaceDetailScreenState extends State<AttandaceDetailScreen> {
  late AttandanceCubit attandanceCubit;
  String? roleName;

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleName = prefs.getString(
          "role_name",
        ) ??
        "";

    print("roleName $roleName");

    setState(() {});
    if (roleName != "Client") {
      attandanceCubit.getAttandance();
    }
  }

  @override
  void initState() {
    attandanceCubit = BlocProvider.of<AttandanceCubit>(context);

    getUserDetailsFromLocal();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        //GlobalColors.backgroundColor,
        centerTitle: true,

        leading: (widget.isBack)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.width(context, 0.05),
                  ),
                ),
                color: Colors.white,
              )
            : Container(),
        title: Text(
          "Attendance".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: roleName == "Client"
          ? Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(context, 0.05)),
        child: Center(
          child: Text(
            "You Don't have permission to view the Attendance".tr(),
            style: TextStyle(
              color: GlobalColors.textFieldHintColor,
              fontSize: SizeConfig.width(context, 0.06),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : roleName == "admin"
          ? AttendanceScreen()  // Navigating to AttandaceScreen if role is admin
          : SingleChildScrollView(
        child: BlocConsumer<AttandanceCubit, AttandanceState>(
          builder: (context, state) {
            if (state is AttandanceSuccess) {
              return (state.attanfanceList.isEmpty)
                  ? Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.height(context, 0.2)),
                  child: Text(
                    "No Data Found".tr(),
                    style: TextStyle(
                        color: GlobalColors.textFieldHintColor,
                        fontSize: SizeConfig.width(context, 0.06)),
                  ),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(state.attanfanceList.length, (index) {
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
                        top: SizeConfig.height(context, 0.02),
                        left: SizeConfig.width(context, 0.04),
                        right: SizeConfig.width(context, 0.04),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${state.attanfanceList[index].formattedDate}",
                                style: TextStyle(
                                    fontSize: SizeConfig.width(context, 0.05),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(3, (indexdata) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  (indexdata) == 0
                                      ? Text(
                                    "Check in".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.width(context, 0.035),
                                        color: GlobalColors.textFieldHintColor),
                                  )
                                      : (indexdata) == 1
                                      ? Text(
                                    "Check out".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.width(context, 0.035),
                                        color: GlobalColors.textFieldHintColor),
                                  )
                                      : Text(
                                    "Duty Hours".tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.width(context, 0.035),
                                        color: GlobalColors.textFieldHintColor),
                                  ),
                                  (indexdata == 0)
                                      ? Text(
                                    state.attanfanceList[index].formattedClockInTime ?? "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.width(context, 0.035),
                                        color: GlobalColors.textFieldHintColor),
                                  )
                                      : (indexdata == 1)
                                      ? Text(
                                    state.attanfanceList[index].formattedClockOutTime ?? "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: SizeConfig.width(context, 0.035),
                                      color: GlobalColors.whiteColor.withOpacity(0.5),
                                    ),
                                  )
                                      : Text(
                                    state.attanfanceList[index].formattedHour ?? "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeConfig.width(context, 0.035),
                                        color: GlobalColors.textFieldHintColor),
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      ));
                }),
              );
            }
            if (state is AttandanceLoading) {
              return const Center(child: LoadingWidget());
            }
            if (state is AttandanceFailure) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.height(context, 0.2)),
                child: Text(
                  "No Data Found".tr(),
                  style: TextStyle(color: Colors.white, fontSize: SizeConfig.width(context, 0.06)),
                ),
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is AttandanceFailure) {
              // Handle failure state
            }
            if (state is AttandanceSuccess) {
              // Handle success state if needed
            }
          },
        ),
      )

    );
  }
}
