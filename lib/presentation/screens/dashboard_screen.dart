import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/logger.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/presentation/cubits/attandance/attandance_cubit.dart';
import 'package:radar/presentation/cubits/create_alert/create_alert_cubit.dart';
import 'package:radar/presentation/cubits/department/department_cubit.dart';
import 'package:radar/presentation/screens/chat_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

bool isJobAccepted = false;

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DepartmentCubit departmentCubit;
  late CreateAlertCubit createAlertCubit;
  late AttandanceCubit attandanceCubit;
  String email = "";
  Timer? _timer;
  String? roleName;
  String name = "";
  String image = "";
  int? userId = 0;
  final _messageController = TextEditingController();

  final alertFormKey = GlobalKey<FormState>();

  double percent = 0.0;

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleName = prefs.getString(
          "role_name",
        ) ??
        "";
    name = prefs.getString(
          "user_name",
        ) ??
        "";
    userId = prefs.getInt(
          "user_id",
        ) ??
        0;
    image = prefs.getString(
          "user_image",
        ) ??
        "";
    email = prefs.getString(
          "user_email",
        ) ??
        "Someone";
    print("roleName $roleName");
    setState(() {});
  }

  String? departmentValue;
  List<String> genderList = ["Male", "Female", "Other"];

  @override
  void initState() {
    LogManager.info("dashboard_usecase.dart");
    departmentCubit = BlocProvider.of<DepartmentCubit>(context);
    attandanceCubit = BlocProvider.of<AttandanceCubit>(context);
    createAlertCubit = BlocProvider.of<CreateAlertCubit>(context);
    attandanceCubit.getAttandanceData();
    //   departmentCubit.getDepartment();
    getUserDetailsFromLocal();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    //  departmentCubit.close();
    // attandanceCubit.close();
    // createAlertCubit.close();
    // TODO: implement dispose
    super.dispose();
  }

  bool showAlert = false;

  @override
  Widget build(BuildContext context) {
    DateTime specificDate = DateTime(2023, 1, 10);
    String formattedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());
    TimeOfDay specificTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    // Format the time as "9:45 AM" or "09:45 AM"
    String formattedTime = specificTime.format(context);
    print("aaaaa $formattedTime $formattedDate");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildDashboardWidget(context, formattedDate, formattedTime),
            (showAlert) ? buildAlertWidget(context) : Container()
          ],
        ),
      ),
    );
  }

  Align buildAlertWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: GlobalColors.backgroundColor, borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02))),
        height: SizeConfig.height(context, 0.75),
        width: SizeConfig.width(context, 0.9),
        padding: EdgeInsets.only(
          left: SizeConfig.width(context, 0.04),
          right: SizeConfig.width(context, 0.04),
          top: SizeConfig.height(context, 0.015),
          bottom: SizeConfig.height(context, 0.015),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: alertFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAlert = false;
                      _messageController.clear();
                      departmentValue = null;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/icons/cancel_icon.png",
                        width: SizeConfig.width(context, 0.035),
                      )
                    ],
                  ),
                ),
                Text(
                  "Get Alert".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.width(context, 0.04),
                  ),
                ),
                Container(
                  width: SizeConfig.width(context, 0.9),
                  margin: EdgeInsets.only(
                    top: SizeConfig.height(context, 0.01),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                      // color: Colors.red,
                      width: SizeConfig.width(context, 0.55),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: GestureDetector(
                          onTap: () {
                            /*      Navigator.pushNamed(
                                    context, AppRoutes.profileScreenRoute);*/
                          },
                          child: (image.contains("http"))
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(image),
                                  radius: SizeConfig.width(context, 0.065),
                                )
                              : CircleAvatar(
                                  backgroundImage: AssetImage("assets/icons/person.png"),
                                  radius: SizeConfig.width(context, 0.065),
                                ),
                        ),
                        title: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.width(context, 0.038),
                          ),
                        ),
                        subtitle: Text(
                          roleName == "Usher".tr() ? "Usher".tr() : "Supervisor".tr(),
                          maxLines: 1,
                          style: TextStyle(
                            color: GlobalColors.goodMorningColor,
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.width(context, 0.030),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: SizeConfig.height(context, 0.02),
                ),
                Material(
                  color: Colors.transparent,
                  shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: GlobalColors.backgroundColor,
                    padding: EdgeInsets.only(),
                    items: ["Accident".tr(), "Misbehave".tr(), "Overcrowd".tr(), "Food".tr(), "Fight".tr()]
                        .map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item ?? "",
                          style: TextStyle(color: GlobalColors.textFieldHintColor),
                        ),
                      );
                    }).toList(),
                    value: departmentValue,
                    onChanged: (value) {
                      setState(() => departmentValue = value);
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Select'.tr(),
                      hintStyle: TextStyle(
                        color: GlobalColors.textFieldHintColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: GlobalColors.submitButtonColor
                            //    color: GlobalColors.ftsTextColor,
                            ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(
                            context,
                            0.03,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                          //    color: GlobalColors.ftsTextColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.03),
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a Department'.tr();
                      }
                      return null;
                    },
                  ),
                  /*  child: BlocConsumer<DepartmentCubit, DepartmentState>(
                    builder: (context, state) {
                      if (state is DepartmentLoading) {
                        return LoadingWidget();
                      }
                      if (state is DepartmentSuccess) {
                        return DropdownButtonFormField<String>(
                          dropdownColor: GlobalColors.backgroundColor,
                          padding: EdgeInsets.only(),
                          items: ["sdfsdfsdf","sdfsdf?","sdfsdf"].map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item ?? "",
                                style: TextStyle(
                                    color: GlobalColors.textFieldHintColor),
                              ),
                            );
                          }).toList(),
                          value: departmentValue,
                          onChanged: (value) {
                            setState(() => departmentValue = value);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Department',
                            hintStyle: TextStyle(
                              color: GlobalColors.textFieldHintColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.yellow
                                  //    color: GlobalColors.ftsTextColor,
                                  ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.03),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: GlobalColors.hintTextColor,
                                //    color: GlobalColors.ftsTextColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.03),
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a Department';
                            }
                            return null;
                          },
                        );
                      }
                      return Container();
                    },
                    listener: (context, state) {
                      if (state is DepartmentFailure) {
                        AppUtils.showFlushBar(state.errorMessage, context);
                      }
                    },
                  ),*/
                ),
                SizedBox(
                  height: SizeConfig.height(context, 0.02),
                ),
                RadiusTextField(
                  leftPadding: 0,
                  rightPadding: 0,
                  maxLength: 9,
                  controller: _messageController,
                  hintText: 'Type Message'.tr(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Message'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: SizeConfig.height(context, 0.03),
                ),
                SubmitButton(
                  gradientFirstColor: GlobalColors.submitButtonColor,
                  width: SizeConfig.width(context, 0.85),
                  onPressed: () async {
                    if (alertFormKey.currentState!.validate()) {
                      AppUtils.showFlushBar("Your Message Has Been Sent Successfully".tr(), context);
                      setState(() {
                        showAlert = false;
                      });
                      /* createAlertCubit.createAlert(
                          description: _messageController.text,
                          departmentId: departmentValue?.id.toString(),
                          to: departmentValue?.teamName,
                          heading: "App");*/
                    }
                    //  Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                  },
                  child: BlocConsumer<CreateAlertCubit, CreateAlertState>(
                    builder: (context, state) {
                      if (state is CreateAlertLoading) {
                        return LoadingWidget();
                      }
                      return Text(
                        'Send Alert'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is CreateAlertSuccess) {
                        setState(() {
                          showAlert = false;
                          _messageController.clear();
                          departmentValue = null;
                        });
                      }
                      if (state is CreateAlertFailure) {
                        AppUtils.showFlushBar(state.errorMessage, context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDashboardWidget(BuildContext context, String formattedDate, String formattedTime) {
    return BlocConsumer<AttandanceCubit, AttandanceState>(builder: (context, state) {
      if (state is DashBoardAttandanceSuccess) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: SizeConfig.width(context, 0.9),
                margin: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.02),
                  //     left: SizeConfig.width(context, 0.05),
                  //     right: SizeConfig.width(context, 0.04)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    // color: Colors.red,
                    width: SizeConfig.width(context, 0.55),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.profileScreenRoute);
                        },
                        child: (image.contains("http"))
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(image),
                                radius: SizeConfig.width(context, 0.065),
                              )
                            : CircleAvatar(
                                backgroundImage: AssetImage("assets/icons/person.png"),
                                radius: SizeConfig.width(context, 0.065),
                              ),
                      ),
                      title: Text(
                        "${"Welcome".tr()} 👋🏻",
                        style: TextStyle(
                          color: GlobalColors.goodMorningColor,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.width(context, 0.030),
                        ),
                      ),
                      subtitle: Text(
                        name,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.width(context, 0.038),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.attandanceDetailScreenRoute);
                        },
                        child: Image.asset(
                          "assets/icons/message_icon.png",
                          width: SizeConfig.width(context, 0.05),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.width(context, 0.04),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.announcementScreen);
                        },
                        child: Image.asset("assets/icons/notification.png", width: SizeConfig.width(context, 0.05)),
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                //  color: Colors.red,
                //    height: SizeConfig.height(context, 0.12),
                width: SizeConfig.width(context, 0.9),
                decoration: BoxDecoration(
                    border: Border.all(color: GlobalColors.textFieldHintColor),
                    color: GlobalColors.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.width(context, 0.02),
                    )),
                margin: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.02),
                  bottom: SizeConfig.height(context, 0.03),
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05),
                ),
                padding: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.01),
                  bottom: SizeConfig.height(context, 0.01),
                  left: SizeConfig.width(context, 0.04),
                  right: SizeConfig.width(context, 0.04),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                          color: GlobalColors.goodMorningColor,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.width(context, 0.05)),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                          color: GlobalColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.width(context, 0.07)),
                    ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 20.0,
                animation: true,
                percent: state.attandanceData.clockOutTime != null ? 0.0 : percent,
                backgroundColor: Color(0xFFEF4A4A).withOpacity(0.2),
                center: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (state.attandanceData.clockOutTime != null)
                        ? Text(
                            "${0}:${0}",
                            style: new TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: SizeConfig.width(context, 0.05)),
                          )
                        : Text(
                            "${state.attandanceData.timeDiff?.h}:${state.attandanceData.timeDiff?.i}",
                            style: new TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: SizeConfig.width(context, 0.05)),
                          ),
                    Text(
                      "RemainingTime".tr(),
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: GlobalColors.goodMorningColor,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.width(context, 0.03),
                      ),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Color(0xFFC79E52),
              ),
              Container(
                //  color: Colors.red,
                height: SizeConfig.height(context, 0.1),
                width: SizeConfig.width(context, 0.9),

                margin: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.03),
                  bottom: SizeConfig.height(context, 0.03),
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return Container(
                      height: SizeConfig.height(context, 0.1),
                      width: SizeConfig.width(context, 0.27),
                      decoration: BoxDecoration(
                        // border: Border.all(color: GlobalColors.textFieldHintColor),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.03),
                        ),
                        color: GlobalColors.primaryColor,
                      ),
                      //   padding: EdgeInsets.only(top: SizeConfig.height(context, 0.022),bottom: SizeConfig.height(context, 0.018)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index == 0
                                ? "${state.attandanceData.clockInTime}"
                                : index == 1
                                    ? "${state.attandanceData.clockOutTime ?? "-"}"
                                    : index == 2
                                        ? "${state.attandanceData.totalHours == null ? "-" : state.attandanceData.totalHours?.h}"
                                        : "",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.width(context, 0.04)),
                          ),
                          Text(
                            index == 0
                                ? "Check In".tr()
                                : index == 1
                                    ? "Check Out".tr()
                                    : index == 2
                                        ? "Total Hours".tr()
                                        : "",
                            style: TextStyle(
                                color: GlobalColors.goodMorningColor,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.width(context, 0.03)),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SubmitButton(
                gradientFirstColor: GlobalColors.submitButtonColor,
                width: SizeConfig.width(context, 0.9),
                onPressed: () async {
                  if (!isJobAccepted) {
                    AppUtils.showFlushBar("Accept a job to proceed.", context);
                    return;
                  }
                  Navigator.pushNamed(context, AppRoutes.qrCodeScreenRoute);
                },
                child: Text(
                  'Qr Code'.tr(),
                  style: TextStyle(
                    color: GlobalColors.submitButtonTextColor,
                    fontSize: SizeConfig.width(context, 0.04),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              SubmitButton(
                gradientFirstColor: const Color(0xFFEF4A4A).withOpacity(0.2),
                width: SizeConfig.width(context, 0.9),
                onPressed: () async {
                  setState(() {
                    showAlert = true;
                  });
                },
                child: Text(
                  'Get Alert'.tr(),
                  style: TextStyle(
                    color: const Color(0xFFEF4A4A),
                    fontSize: SizeConfig.width(context, 0.04),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: SizeConfig.width(context, 0.9),
              margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.02),
                //     left: SizeConfig.width(context, 0.05),
                //     right: SizeConfig.width(context, 0.04)
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  // color: Colors.red,
                  width: SizeConfig.width(context, 0.55),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profileScreenRoute);
                      },
                      child: (image.contains("http"))
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(image),
                              radius: SizeConfig.width(context, 0.065),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/person.png"),
                              radius: SizeConfig.width(context, 0.065),
                            ),
                    ),
                    title: Text(
                      "${"Welcome".tr()} 👋🏻",
                      style: TextStyle(
                        color: GlobalColors.goodMorningColor,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.width(context, 0.035),
                      ),
                    ),
                    subtitle: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.width(context, 0.038),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.attandanceDetailScreenRoute);
                      },
                      child: Image.asset(
                        "assets/icons/message_icon.png",
                        width: SizeConfig.width(context, 0.05),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.width(context, 0.04),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.announcementScreen);
                      },
                      child: Image.asset("assets/icons/notification.png", width: SizeConfig.width(context, 0.05)),
                    ),
                  ],
                )
              ]),
            ),
            Container(
              //  color: Colors.red,
              //    height: SizeConfig.height(context, 0.12),
              width: SizeConfig.width(context, 0.9),
              decoration: BoxDecoration(
                  border: Border.all(color: GlobalColors.textFieldHintColor),
                  color: GlobalColors.backgroundColor,
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width(context, 0.02),
                  )),
              margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.02),
                bottom: SizeConfig.height(context, 0.03),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05),
              ),
              padding: EdgeInsets.only(
                top: SizeConfig.height(context, 0.01),
                bottom: SizeConfig.height(context, 0.01),
                left: SizeConfig.width(context, 0.04),
                right: SizeConfig.width(context, 0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                        color: GlobalColors.goodMorningColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.width(context, 0.05)),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(
                        color: GlobalColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.width(context, 0.07)),
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 20.0,
              animation: true,
              percent: 0,
              backgroundColor: Color(0xFFEF4A4A).withOpacity(0.2),
              center: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00:00",
                    style: new TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white, fontSize: SizeConfig.width(context, 0.05)),
                  ),
                  Text(
                    "RemainingTime".tr(),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: GlobalColors.goodMorningColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.width(context, 0.03),
                    ),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFFC79E52),
            ),
            Container(
              //  color: Colors.red,
              height: SizeConfig.height(context, 0.1),
              width: SizeConfig.width(context, 0.9),

              margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.03),
                bottom: SizeConfig.height(context, 0.03),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Container(
                    height: SizeConfig.height(context, 0.1),
                    width: SizeConfig.width(context, 0.27),
                    decoration: BoxDecoration(
                      // border: Border.all(color: GlobalColors.textFieldHintColor),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                      color: GlobalColors.primaryColor,
                    ),
                    //   padding: EdgeInsets.only(top: SizeConfig.height(context, 0.022),bottom: SizeConfig.height(context, 0.018)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.width(context, 0.04)),
                        ),
                        Text(
                          index == 0
                              ? "Check In".tr()
                              : index == 1
                                  ? "Check Out".tr()
                                  : "Total Hours".tr(),
                          style: TextStyle(
                              color: GlobalColors.goodMorningColor,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.width(context, 0.03)),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            SubmitButton(
              gradientFirstColor: GlobalColors.submitButtonColor,
              width: SizeConfig.width(context, 0.9),
              onPressed: () async {
                if (!isJobAccepted) {
                  AppUtils.showFlushBar("Accept a job to proceed.", context);
                  return;
                }

                Navigator.pushNamed(context, AppRoutes.qrCodeScreenRoute);
              },
              child: Text(
                'Qr Code'.tr(),
                style: TextStyle(
                  color: GlobalColors.submitButtonTextColor,
                  fontSize: SizeConfig.width(context, 0.04),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.height(context, 0.02),
            ),
            SubmitButton(
              gradientFirstColor: const Color(0xFFEF4A4A).withOpacity(0.2),
              width: SizeConfig.width(context, 0.9),
              onPressed: () async {
                setState(() {
                  showAlert = true;
                });
              },
              child: Text(
                'Get Alert'.tr(),
                style: TextStyle(
                  color: const Color(0xFFEF4A4A),
                  fontSize: SizeConfig.width(context, 0.04),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is DashBoardAttandanceSuccess) {
        if (state.attandanceData.timeDiff?.h == null) {
          percent = 0;
        } else {
          percent = ((state.attandanceData.timeDiff?.h) ?? 1 + (state.attandanceData.timeDiff?.m ?? 1) / 60) / 24;
        }
        _timer = Timer.periodic(Duration(seconds: 60), (timer) async {
          if (mounted) {
            attandanceCubit.getAttandanceData(userId: userId);
          }
        });
      }
      if (state is AttandanceFailure) {
        //  AppUtils.showFlushBar(state.errorMessage, context);
      }
    });
  }
}

class HourPercentIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final double percentOfDay = (now.hour + now.minute / 60) / 24;

    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 50,
      lineHeight: 14.0,
      percent: percentOfDay,
      backgroundColor: Colors.grey[300],
      progressColor: Colors.blue,
      center: Text('${(percentOfDay * 100).toStringAsFixed(2)}% of the day has passed'),
    );
  }
}
