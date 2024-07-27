import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/logger.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/department/Department.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/presentation/cubits/attandance/attandance_cubit.dart';
import 'package:radar/presentation/cubits/create_alert/create_alert_cubit.dart';
import 'package:radar/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:radar/presentation/cubits/department/department_cubit.dart';
import 'package:radar/presentation/screens/chat_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_client/web_socket_client.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> with WidgetsBindingObserver {
  late DepartmentCubit departmentCubit;
  late CreateAlertCubit createAlertCubit;
  late DashboardCubit dashboardCubit;
  late AttandanceCubit attandanceCubit;
  String email = "";
  Timer? _timer;
  String? roleName;
  String name = "";
  String image = "";
  int? userId = 0;
  final _messageController = TextEditingController();

  final alertFormKey = GlobalKey<FormState>();
  _sendMessage() {
    print("mesaafedsdfsdfsdf");
    _socket.emit('riderevent:4631', {"message": "message agaya234234234234"});
    _socket.on('rideTest_4631', (data) => print("recieved message $data"));
  }

  _connectSocket() {
    _socket.onConnect((data) {
      print("socket conected");
      _sendMessage();
    });
    _socket.onConnectError((data) {
      print("socket connection error");
    });
    _socket.onDisconnect((data) {
      print("socket connection disconnected");
    });
  }

  double percent = 0.0;
  String? gender;

  LatestEventModel? eventValue;

  int? eventId;

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
  late IO.Socket _socket;
  WebSocket? socket;
  bool isAppInBackground = false;
  Future websocket() async {
    final uri = Uri.parse('ws://192.168.0.100:4000/');
    const backoff = ConstantBackoff(Duration(seconds: 1));
    socket = WebSocket(uri, backoff: backoff);
    print("object1111 ${socket?.connection.state}");
    // Listen for changes in the connection state.

    socket?.connection.listen((state) {
      print(
        'state:11 "$state"',
      );

      if (state.toString() == "Instance of 'Connected'") {
        AppUtils.showFlushBar("Connected", context);

        socket?.send("aaaaaaaaaaaaaaaaaaaaaaaa");
        AppUtils.showFlushBar("Connected send", context);
        socket?.messages.listen((message) {
          print('message:11111122222 "$message"');
        });
      }
      if (state.toString() == "Instance of 'Reconnected'") {
        AppUtils.showFlushBar("Connected", context);

        socket?.send("Re aaaaaaaaaaaaaaaaaaaaaaaa");
        AppUtils.showFlushBar("ReConnected send", context);
        socket?.messages.listen((message) {
          print('message:11111122222 "$message"');
        });
      }
      if (state.toString() == "Instance of 'Disconnected'") {
        AppUtils.showFlushBar("Disconnected", context);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState state = ${state.name}');

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.detached) return;

    isAppInBackground = state == AppLifecycleState.paused;

    if (isAppInBackground) {
      determinePosition();
    }
    super.didChangeAppLifecycleState(state);
  }

  Timer? _myTimer;
  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    currentLocation = '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}';
    print("if case ${position.latitude}");
    print("if case $currentLocation");

    if (mounted) {
      setState(() {});
    }
    //return await Geolocator.getCurrentPosition();
  }

  String? currentLocation;
  every2seconds() async {
    _myTimer = Timer.periodic(const Duration(seconds: 60), (Timer t) async {
      LocationPermission permission = await Geolocator.checkPermission();
      print("inside every2seconds $permission");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          print('permission denied');
          return Future.error('Location Not Available');
        }
      }
      print("inside every2seconds");
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      currentLocation = '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}';
      print("if case ${position.latitude}");
      print("if case $currentLocation");
    });
  }

  @override
  void initState() {
    determinePosition();
    //  websocket();

    LogManager.info("Admin dashboard_usecase.dart");
    departmentCubit = BlocProvider.of<DepartmentCubit>(context);
    attandanceCubit = BlocProvider.of<AttandanceCubit>(context);
    dashboardCubit = BlocProvider.of<DashboardCubit>(context);
    createAlertCubit = BlocProvider.of<CreateAlertCubit>(context);

    attandanceCubit.latestEvent();
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
        body: RefreshIndicator(
          onRefresh: () async {
            attandanceCubit.latestEvent();
            getUserDetailsFromLocal();
          },
          child: ListView(
            children: [
              Container(
                width: SizeConfig.width(context, 0.9),
                margin: EdgeInsets.only(
                    top: SizeConfig.height(context, 0.02),
                    left: SizeConfig.width(context, 0.05),
                    right: SizeConfig.width(context, 0.05)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  SizedBox(
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
                      (roleName == "Client")
                          ? Container()
                          : InkWell(
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
              SizedBox(
                height: SizeConfig.height(context, 0.01),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.01),
                  bottom: SizeConfig.height(context, 0.02),
                  left: SizeConfig.width(context, 0.05),
                  right: SizeConfig.width(context, 0.05),
                ),
                child: Material(
                  color: Colors.transparent,
                  shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                  child: BlocConsumer<AttandanceCubit, AttandanceState>(
                    listener: (context, state) {
                      if (state is DashboardDetailEventSuccess) {
                        if (state.attanfanceList.isNotEmpty) {
                          eventValue = state.attanfanceList.first;
                          print("aaaaaaaaaaaaaaaaa");
                          setState(() {
                            eventId = eventValue?.id;
                          });
                          dashboardCubit.dashboardDetail(eventId: eventId);
                        }
                      }
                    },
                    builder: (context, state) {
                      print("latest  event detail $state");
                      if (state is AttandanceLoading) {
                        return const LoadingWidget();
                      }
                      if (state is DashboardDetailEventSuccess) {
                        print("inside this 2 ${state.attanfanceList.length}");
                        return DropdownButtonFormField<LatestEventModel>(
                          isExpanded: true,
                          dropdownColor: GlobalColors.backgroundColor,
                          padding: EdgeInsets.only(),
                          items: state.attanfanceList.map((LatestEventModel item) {
                            return DropdownMenuItem<LatestEventModel>(
                              value: item,
                              child: Text(
                                item.eventName ?? "",
                                style: TextStyle(color: GlobalColors.textFieldHintColor),
                              ),
                            );
                          }).toList(),
                          value: eventValue,
                          onChanged: (value) {
                            setState(() {
                              eventValue = value;
                              eventId = eventValue?.id;
                            });
                            dashboardCubit.dashboardDetail(eventId: eventId);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Select Event'.tr(),
                            hintStyle: TextStyle(
                              color: GlobalColors.textFieldHintColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: GlobalColors.submitButtonColor
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
                              return 'Please select a Event';
                            }
                            return null;
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              buildDashboardWidget(context, formattedDate, formattedTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDashboardWidget(BuildContext context, String formattedDate, String formattedTime) {
    return BlocConsumer<DashboardCubit, DashboardState>(builder: (context, state) {
      if (state is DashboardDetailSuccess) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 10.0,
                animation: true,
                percent: percent,
                backgroundColor: const Color(0xFFEF4A4A).withOpacity(0.2),
                center: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${state.dashboardDetail.checkins}/${state.dashboardDetail.totalSeats}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white, fontSize: SizeConfig.width(context, 0.04)),
                    ),
                    Text(
                      "Check In".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
              (roleName == "Client")
                  ? Container(
                      //  color: Colors.red,
                      height: SizeConfig.height(context, 0.1),
                      //   width: SizeConfig.width(context, 0.9),

                      margin: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.03),
                        bottom: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.1),
                        right: SizeConfig.width(context, 0.1),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(2, (index) {
                          return Container(
                            //   height: SizeConfig.height(context, 0.1),
                            width: SizeConfig.width(context, 0.23),
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
                                      ? "${state.dashboardDetail.totalZone}"
                                      : index == 1
                                          ? "${state.dashboardDetail.invitedUshers}"
                                          : index == 2
                                              ? "${state.dashboardDetail.confirmedBudget}"
                                              : "${state.dashboardDetail.confirmedUshers}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.width(context, 0.04)),
                                ),
                                Text(
                                  index == 0
                                      ? "Total Zones".tr()
                                      : index == 1
                                          ? "Invited Ushers".tr()
                                          : index == 2
                                              ? "Confirmed Budget".tr()
                                              : "On-spot Ushers".tr(),
                                  textAlign: TextAlign.center,
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
                    )
                  : Container(
                      //  color: Colors.red,
                      height: SizeConfig.height(context, 0.1),
                      //   width: SizeConfig.width(context, 0.9),

                      margin: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.03),
                        bottom: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.1),
                        right: SizeConfig.width(context, 0.1),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          return Container(
                            //   height: SizeConfig.height(context, 0.1),
                            width: SizeConfig.width(context, 0.23),
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
                                      ? "${state.dashboardDetail.plannedBudget}"
                                      : index == 1
                                          ? "${state.dashboardDetail.invitedUshers}"
                                          : index == 2
                                              ? "${state.dashboardDetail.confirmedBudget}"
                                              : "${state.dashboardDetail.confirmedUshers}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.width(context, 0.04)),
                                ),
                                Text(
                                  index == 0
                                      ? "Planned Budget".tr()
                                      : index == 1
                                          ? "Invited Ushers".tr()
                                          : index == 2
                                              ? "Confirmed Budget".tr()
                                              : "On-spot Ushers".tr(),
                                  textAlign: TextAlign.center,
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
              (roleName == "Client")
                  ? Container(
                      height: SizeConfig.height(context, 0.1),
                      margin: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.1),
                        right: SizeConfig.width(context, 0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(2, (index) {
                          return Container(
                            //   height: SizeConfig.height(context, 0.1),
                            width: SizeConfig.width(context, 0.23),
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
                                      ? "${state.dashboardDetail.plannedUshers}"
                                      : index == 1
                                          ? "${state.dashboardDetail.confirmedUshers}"
                                          : index == 2
                                              ? "${state.dashboardDetail.totalZone}"
                                              : "${state.dashboardDetail.confirmedUshers}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.width(context, 0.04)),
                                ),
                                Text(
                                  index == 0
                                      ? "Planed Ushers".tr()
                                      : index == 1
                                          ? "On-spot Ushers".tr()
                                          : index == 2
                                              ? "Total Zones".tr()
                                              : "On-spot Ushers".tr(),
                                  textAlign: TextAlign.center,
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
                    )
                  : Container(
                      height: SizeConfig.height(context, 0.1),
                      margin: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.1),
                        right: SizeConfig.width(context, 0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          return Container(
                            //   height: SizeConfig.height(context, 0.1),
                            width: SizeConfig.width(context, 0.23),
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
                                      ? "${state.dashboardDetail.plannedUshers}"
                                      : index == 1
                                          ? "${state.dashboardDetail.confirmedUshers}"
                                          : index == 2
                                              ? "${state.dashboardDetail.totalZone}"
                                              : "${state.dashboardDetail.confirmedUshers}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.width(context, 0.04)),
                                ),
                                Text(
                                  index == 0
                                      ? "Planed Ushers".tr()
                                      : index == 1
                                          ? "On-spot Ushers".tr()
                                          : index == 2
                                              ? "Total Zones".tr()
                                              : "On-spot Ushers".tr(),
                                  textAlign: TextAlign.center,
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
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height(context, 0.03),
                  bottom: SizeConfig.height(context, 0.03),
                  left: SizeConfig.width(context, 0.08),
                  right: SizeConfig.width(context, 0.08),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubmitButton(
                      gradientFirstColor: GlobalColors.primaryColor,
                      width: SizeConfig.width(context, 0.4),
                      onPressed: () async {
                        print("event value zone ${state.dashboardDetail.eventId?.toInt()}");
                        Navigator.pushNamed(context, AppRoutes.dashboardZone,
                            arguments: ZoneDashboardScreenRoute(eventId: eventId ?? 0));
                      },
                      child: Text(
                        'Zones'.tr(),
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
                      gradientFirstColor: GlobalColors.primaryColor,
                      width: SizeConfig.width(context, 0.4),
                      onPressed: () async {
                        print("event id job ${state.dashboardDetail.eventId}");
                        Navigator.pushNamed(context, AppRoutes.dashboardJob,
                            arguments: JobDashboardScreenRoute(eventId: eventId ?? 0));
                      },
                      child: Text(
                        'Jobs'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SubmitButton(
                gradientFirstColor: const Color(0xFFC1954A),
                onPressed: () async {
                  if (kDebugMode) {
                    print("event value zone ${state.dashboardDetail.eventId?.toInt()}");
                  }
                  Navigator.pushNamed(context, AppRoutes.usherListByEventScreenRoute,
                      arguments: UsherListByEventScreenRoute(eventId: eventId ?? 0));
                },
                child: Text(
                  "${'Outside Usher'.tr()}   ${state.dashboardDetail.usherCountOutside ?? 0}",
                  style: TextStyle(
                    color: GlobalColors.submitButtonTextColor,
                    fontSize: SizeConfig.width(context, 0.04),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return
          //  Container()
          SingleChildScrollView(
        child: Column(
          children: [
            (roleName == "Client")
                ? Container(
                    //  color: Colors.red,
                    height: SizeConfig.height(context, 0.1),
                    width: SizeConfig.width(context, 0.9),

                    margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.03),
                      bottom: SizeConfig.height(context, 0.01),
                      left: SizeConfig.width(context, 0.1),
                      right: SizeConfig.width(context, 0.1),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(2, (index) {
                        return Container(
                          //   height: SizeConfig.height(context, 0.1),
                          width: SizeConfig.width(context, 0.2),
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
                                    ? "Total Zones".tr()
                                    : index == 1
                                        ? "Invited Ushers".tr()
                                        : index == 2
                                            ? "Confirmed Budget".tr()
                                            : "On-spot Ushers".tr(),
                                textAlign: TextAlign.center,
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
                  )
                : Container(
                    //  color: Colors.red,
                    height: SizeConfig.height(context, 0.1),
                    width: SizeConfig.width(context, 0.9),

                    margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.03),
                      bottom: SizeConfig.height(context, 0.01),
                      left: SizeConfig.width(context, 0.1),
                      right: SizeConfig.width(context, 0.1),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) {
                        return Container(
                          //   height: SizeConfig.height(context, 0.1),
                          width: SizeConfig.width(context, 0.2),
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
                                    ? "Planed Ushers".tr()
                                    : index == 1
                                        ? "Invited Ushers".tr()
                                        : index == 2
                                            ? "Confirmed Budget".tr()
                                            : "On-spot Ushers".tr(),
                                textAlign: TextAlign.center,
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
            (roleName == "Client")
                ? Container(
                    //  color: Colors.red,
                    height: SizeConfig.height(context, 0.1),
                    width: SizeConfig.width(context, 0.9),

                    margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.01),
                      left: SizeConfig.width(context, 0.1),
                      right: SizeConfig.width(context, 0.1),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(2, (index) {
                        return Container(
                          //   height: SizeConfig.height(context, 0.1),
                          width: SizeConfig.width(context, 0.2),
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
                                    ? "Planed Ushers".tr()
                                    : index == 1
                                        ? "On-spot Ushers".tr()
                                        : index == 2
                                            ? "Confirmed Budget".tr()
                                            : "On-spot Ushers".tr(),
                                textAlign: TextAlign.center,
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
                  )
                : Container(
                    //  color: Colors.red,
                    height: SizeConfig.height(context, 0.1),
                    width: SizeConfig.width(context, 0.9),

                    margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.01),
                      left: SizeConfig.width(context, 0.1),
                      right: SizeConfig.width(context, 0.1),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) {
                        return Container(
                          //   height: SizeConfig.height(context, 0.1),
                          width: SizeConfig.width(context, 0.2),
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
                                    ? "Planed Ushers".tr()
                                    : index == 1
                                        ? "Invited Ushers".tr()
                                        : index == 2
                                            ? "Confirmed Budget".tr()
                                            : "On-spot Ushers".tr(),
                                textAlign: TextAlign.center,
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
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.height(context, 0.03),
                bottom: SizeConfig.height(context, 0.03),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubmitButton(
                    gradientFirstColor: GlobalColors.primaryColor,
                    width: SizeConfig.width(context, 0.4),
                    onPressed: () async {
                      //    Navigator.pushNamed(context, AppRoutes.qrCodeScreenRoute);
                    },
                    child: Text(
                      'Zones'.tr(),
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
                    gradientFirstColor: GlobalColors.primaryColor,
                    width: SizeConfig.width(context, 0.4),
                    onPressed: () async {
                      //    Navigator.pushNamed(context, AppRoutes.dashboardJob);
                    },
                    child: Text(
                      'Jobs'.tr(),
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is DashboardDetailSuccess) {}
      if (state is DashboardDetailFailed) {
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
