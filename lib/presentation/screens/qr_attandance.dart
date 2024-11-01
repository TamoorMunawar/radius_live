import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as m;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/extensions.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/data/radar_mobile_repository_impl.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/domain/usecase/event/event_detail/event_detail_usecase.dart';
import 'package:radar/domain/usecase/scan_qr_code/scan_qr_code_usecase.dart';
import 'package:radar/presentation/cubits/events/initial_events/initial_event_cubit.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/cubits/zone_seats/zone_seats_cubit.dart';
import 'package:radar/presentation/screens/dashboard_screen.dart';
import 'package:radar/presentation/screens/events.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/network_utils.dart';
import '../../domain/entities/events/event_detail/Event_detail.dart';
import '../../domain/entities/events/event_detail/Event_zone_all.dart';
import '../../domain/entities/events/event_detail/GetZone.dart'as eGetZone;
import '../../domain/entities/events/event_detail/GetZone.dart';
import '../../domain/repository/logistics_repo.dart';
import '../cubits/events/event_detail/event_detail_cubit.dart';
import 'event_detail_screen.dart';
import 'package:http/http.dart' as http
;
class QrAttandanceScreen extends StatefulWidget {

  QrAttandanceScreen({super.key,});

  @override
  State<QrAttandanceScreen> createState() => _QrAttandanceScreenState();
}

class _QrAttandanceScreenState extends State<QrAttandanceScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  String removeHtmlTags(String htmlString) {
    final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);

    return htmlString.replaceAll(regExp, '');
  }
  EventDetail? eventDetail;
  List<Tabs> tabList = [
    Tabs(
      title: "Check In".tr(),
      isSelected: true,
    ),
    Tabs(
      title: "Check Out".tr(),
      isSelected: false,
    ),
  ];
  int count = 1;
  int finalCount = 1;
  late ScanQrCodeCubit scanQrCodeCubit;
  late InitialEventCubit initialEventCubit;
  late EventDetailCubit eventDetailCubit;
  late ZoneSeatsCubit zoneSeatsCubit;
  // late ZoneCubit zoneCubit;
  String? roleName;
  bool showAlert = false;
  final alertFormKey = GlobalKey<FormState>();
  EventZoneAll? zoneValue;

  int? checkInEventModelId = 0;

  int? checkOutEventModelId = 0;

  bool isCheckInValue = false;
  int? attendanceEventId;
  InitialEvent? _initialEvent;
  final ScanQrCodeUsecase _qrCodeUsecase = ScanQrCodeUsecase(repository: RadarMobileRepositoryImpl());

  _getAttendance() async {
    final result = await _qrCodeUsecase.getToday();

    log(result.toString(), name: "Attendance result");
    if (result != null) {
      setState(() {
        isCheckInValue = true;
        attendanceEventId = result.$2;
        print(attendanceEventId);

      });
    }
  }

  Future _checkInScrollListener() async {
    if (isLoadingMoreCheckIn) return;
    if (checkInScrollController.position.pixels == checkInScrollController.position.maxScrollExtent) {
      log("if scroll listener called");
      setState(() {
        isLoadingMoreCheckIn = true;
      });
      count = count + 1;

      initialEventCubit.getInitialEvent(page: count);
    }
    setState(() {
      isLoadingMoreCheckIn = false;
    });
  }

  Future _finalScrollListener() async {
    if (isLoadingMoreCheckout) return;
    if (checkOutScrollController.position.pixels == checkOutScrollController.position.maxScrollExtent) {
      log("if scroll listener called");
      setState(() {
        isLoadingMoreCheckout = true;
      });
      finalCount = finalCount + 1;
      finalEventList.addAll(await initialEventCubit.getFinalEventTest(page: finalCount));
      //  initialEventCubit.getFinalEvent(page: finalCount);
    }
    setState(() {
      isLoadingMoreCheckout = false;
    });
  }

  getFinalEventData() async {
    setState(() {
      isLoadingMoreCheckout = true;
    });
    finalEventList = await initialEventCubit.getFinalEventTest(page: finalCount);
    log("finalEventList ${finalEventList.length}");
    setState(() {
      isLoadingMoreCheckout = false;
    });
  }

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    eventImagePath = prefs.getString("event_image_path") ?? "";
    roleName = prefs.getString(
      "role_name",
    ) ??
        "";
    log("role name $roleName");
    setState(() {});
  }

  double latitude = 0.0;
  double longitude = 0.0;

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
    log("position.latitude ${position.latitude}");
    log("position.longitude ${position.longitude}");
    latitude = position.latitude;
    longitude = position.longitude;
    if (mounted) {
      setState(() {});
    }
    //return await Geolocator.getCurrentPosition();
  }

  final checkInScrollController = ScrollController();
  final checkOutScrollController = ScrollController();
  bool isLoadingMoreCheckIn = false;
  bool isLoadingMoreCheckout = false;
  List<InitialEvent> finalEventList = [];
  String? eventImagePath;
  String noInternetConnectivityMsg = 'Please check your internet connection  and try again.'.tr();
  String noTimeOutMsg = 'Time out try again'.tr();
  var ZoneId;
  @override
  void initState() {
    scanQrCodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);
    // zoneCubit = BlocProvider.of<ZoneCubit>(context);
    initialEventCubit = BlocProvider.of<InitialEventCubit>(context);
    // zoneSeatsCubit = BlocProvider.of<ZoneSeatsCubit>(context);
    checkInScrollController.addListener(_checkInScrollListener);
    checkOutScrollController.addListener(_finalScrollListener);
    _getAttendance();
    determinePosition();
    getUserDetailsFromLocal();

    getFinalEventData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // scanQrCodeCubit.close();
    // zoneCubit.close();
  }
  Future<EventDetail> getEventDetailById({int? eventId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
        // '${NetworkUtils.baseUrl}/events/event_details/${prefs.getInt("user_id")}');
          '${NetworkUtils.baseUrl}/events/event_details/$eventId');

      http.Response response = await http.get(
        url,
        headers: authorizationHeaders(prefs),
      );
      log("repository::getEventDetailById::url: $url \n");

      log("repository::getEventDetailById::responseBody: ${response.body}\n");

      var responseBody = jsonDecode(response.body);

      if (responseBody["success"] != true) {
        throw Exception(responseBody["message"]);
      }
      prefs.setString("event_image_path", "${responseBody['data']['event_img_path']}");
      return EventDetail.fromJson(responseBody["data"]["data"]);
    } on TimeoutException catch (e) {
      throw Exception(noTimeOutMsg);
    } on SocketException catch (e) {
      throw Exception(noInternetConnectivityMsg);
    } on Exception catch (e) {
      print('repository::getEventDetailById::exception = ${e.toString()}');
      throw Exception(e.toString().substring(11));
    }
  }
  Future<File?> _pickImageFromCamera() async {
    final XFile? picker = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picker != null) {
      return File(picker.path);
    }
    return null;
  }

  bool _checkIfWithinRadius({String? zoneLat, String? zoneLong, String? zonRadius}) {
    if (latitude == 0.0 && longitude == 0.0) return false;

    final distance = _calculateDistance(
      double.parse(zoneLat ?? "0.0"),
      double.parse(zoneLong ?? "0.0"),
      latitude,
      longitude,
    );

    if (distance <= double.parse(zonRadius ?? "0.0")) {
      return true;
    } else {
      return false;
    }
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - m.cos((lat2 - lat1) * p) / 2 + m.cos(lat1 * p) * m.cos(lat2 * p) * (1 - m.cos((lon2 - lon1) * p)) / 2;
    return 12742 * m.asin(m.sqrt(a)) * 1000; // Distance in meters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Attendance".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              (isLoadingMoreCheckout)
                  ? const LoadingWidget()
                  : (finalEventList.isEmpty)
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.height(context, 0.2)),
                  child: Text(
                    "No Data Found".tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.width(context, 0.06)),
                  ),
                ),
              )
                  : Expanded(
                child: ListView.separated(
                  //   primary: true,
                  // shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: SizeConfig.height(context, 0.1)),

                  controller: checkOutScrollController,
                  itemBuilder: (context, index) {
                    var item = finalEventList.elementAt(index);
                    if (index < finalEventList.length) {
                      return EventsTab(
                        onTap: () {
                          setState(() {
                            showAlert = true;
                            checkOutEventModelId = item.id;
                            // isCheckInValue = false;
                            _initialEvent = item;

                          });

                          if (attendanceEventId == null) {
                          } else if (attendanceEventId != checkOutEventModelId) {
                            AppUtils.showFlushBar("Please checkout from other event", context);
                          }
                          // zoneCubit.getZone(eventId: item.id);
                        },
                        title: "${item.eventName}",
                        subtitle:
                        "${removeHtmlTags(item.projectSummary ?? "")} \n ${item.startDate} to ${item.endDate}",
                        imagePath: "$eventImagePath${item.logo}",
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.height(context, 0.2),
                          ),
                          const LoadingWidget(),
                        ],
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox();
                  },
                  itemCount:
                  (isLoadingMoreCheckout) ? finalEventList.length ?? 0 + 1 : finalEventList.length ?? 0,
                ),
              )
            ],
          ),
          (showAlert)
              ? attendanceEventId == checkOutEventModelId || attendanceEventId == null
              ? buildAlertWidget(context: context, isCheckIn: isCheckInValue, event: _initialEvent)
              : Container()
              : Container(),
          BlocListener<ScanQrCodeCubit, ScanQrCodeState>(
            listener: (context, state) {
              if (state is ScanQrcodeSuccess) {
                AppUtils.showFlushBar("Attandance Marked Successfully".tr(), context);
              }
              if (state is ScanQrcodeFailure) {
                AppUtils.showFlushBar(state.errorMessage, context);
              }
              if (state is UsherCheckinSuccess) {
                AppUtils.showFlushBar("Usher checked in successfully", context);
              }
              if (state is UsherCheckoutSuccess) {
                AppUtils.showFlushBar("Usher checked out successfully", context);
              }
              if (state is UsherAttendanceFailure) {
                AppUtils.showFlushBar(state.errorMessage, context);
              }
            },
            child: Container(),
          )
        ],
      ),
    );
  }

  Align buildAlertWidget({required BuildContext context, required bool isCheckIn, required InitialEvent? event}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: GlobalColors.primaryColor, borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02))),
        height: SizeConfig.height(context, 0.5),
        width: SizeConfig.width(context, 0.9),
        padding: EdgeInsets.only(
          left: SizeConfig.width(context, 0.04),
          right: SizeConfig.width(context, 0.04),
          top: SizeConfig.height(context, 0.015),
          bottom: SizeConfig.height(context, 0.015),
        ),
        child: Form(
          key: alertFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAlert = false;
                    print(event?.id);
                    zoneValue = null;
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
                (!isCheckInValue) ? 'Check In'.tr() : 'Check out'.tr(),
                // "${isCheckInValue}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.width(context, 0.04),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              FutureBuilder<EventDetail>(
                future: getEventDetailById(eventId: event?.id), // Fetch event details here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final event = snapshot.data!;
                    final zoneText = event.eventZonesAll != null && event.eventZonesAll!.isNotEmpty
                        ? event.eventZonesAll!.first.getZone?.categoryName ?? "No Zone Available"
                        : "No Zone Available";
                    ZoneId = event.eventZonesAll!.first.zoneId;
                    print(ZoneId);
                    print("this is zone ID");
                    return  Padding(
                      padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.02.sh, horizontal: 0.02.sh),
                        decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.hintTextColor),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: Text(zoneText ?? "",
                            style: TextStyle(
                              color: GlobalColors.hintTextColor,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Expanded(

                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      latitude,
                      longitude,
                    ),
                    zoom: 11.0,
                  ),
                  circles: {
                    Circle(
                      circleId: const CircleId('center_circle'),
                      center: LatLng(
                        double.parse(event!.latitude!),
                        double.parse(event.longitude!),
                      ),
                      radius: double.parse(event.radius!),
                      fillColor: Colors.blue.withOpacity(0.5),
                      strokeColor: Colors.blue,
                      strokeWidth: 1,
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.03),
              ),
              BlocConsumer<ScanQrCodeCubit, ScanQrCodeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return !isCheckInValue
                      ? SubmitButton(
                      gradientFirstColor: GlobalColors.submitButtonColor,
                      width: SizeConfig.width(context, 0.85),
                      onPressed: () async {
                        print("tamoor");
                        print(ZoneId);
                        print(event.latitude);
                        print(event.longitude);
                        print(event.radius);
                        print(longitude);
                        print(latitude);
                        File? image = await _pickImageFromCamera();

                        if (image == null) {
                          AppUtils.showFlushBar("Please capture your image!", context);
                          return;
                        }

                        bool isWithinRadius = _checkIfWithinRadius(
                            zoneLat: event.latitude, zoneLong: event.longitude, zonRadius: event.radius);
                        if (ZoneId == null) {
                          AppUtils.showFlushBar("Please select a Zone".tr(), context);
                          return;
                        }
                        if (!isWithinRadius) {
                          AppUtils.showFlushBar("You are not in the Zone", context);

                          return;
                        }
                        log(roleName ?? "Role");

                        if (roleName != "Usher") {
                          AppUtils.showFlushBar("You don't have permission to marked the Attandance".tr(), context);
                          return;
                        }
                        log(event.id.toString());
                        log(ZoneId.toString() ?? "Zone is null");
                        print("tamoor munawar");
                        print(ZoneId);
                        scanQrCodeCubit.usherCheckIn(
                          eventId: event.id,
                          latitude: latitude,
                          longitude: longitude,
                          zoneId: ZoneId,
                        );

                        setState(() {
                          showAlert = false;
                          zoneValue = null;
                          isJobAccepted = true;
                        });
                        //  Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                      },
                      child: Text(
                        'Check In'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                      : SubmitButton(
                      gradientFirstColor: GlobalColors.submitButtonColor,
                      width: SizeConfig.width(context, 0.85),
                      onPressed: () async {
                        if (ZoneId == null) {
                          AppUtils.showFlushBar("Please select a Zone".tr(), context);
                          return;
                        }

                        log(roleName ?? "Role");
                        if (roleName != "Usher") {
                          AppUtils.showFlushBar("You don't have permission to marked the Attandance".tr(), context);
                          return;
                        }

                        scanQrCodeCubit.usherCheckout();
                        // var res = await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SimpleBarcodeScannerPage(),
                        //     ));
                        // print("resssssv $res");
                        // var response = jsonDecode(res);
                        // ScanQrCodePayload qrcodeResult = ScanQrCodePayload.fromJson(response);
                        // print("resssssvisCheckInValue ${isCheckInValue}");
                        // qrcodeResult.type = (isCheckInValue) ? "checkIn" : "CheckOut";
                        // print("ScanQrCodePayload ${qrcodeResult.name}");
                        // print("ScanQrCodePayload ${qrcodeResult.id}");
                        // print("ScanQrCodePayload ${qrcodeResult.id}");
                        // if (qrcodeResult?.name?.isNotEmpty ?? false) {
                        //   scanQrCodeCubit.scanQrCodeByEventId(
                        //     isCheckout: (isCheckInValue) ? false : true,
                        //     eventModelId: (isCheckInValue) ? checkInEventModelId : checkOutEventModelId,
                        //     zoneId: zoneValue?.id,
                        //     latitude: latitude,
                        //     longitude: longitude,
                        //     scanQrCodePayload: qrcodeResult,
                        //     userId: qrcodeResult.id,
                        //   );
                        // }
                        setState(() {
                          showAlert = false;
                          zoneValue = null;
                          isJobAccepted = false;
                        });
                        //  Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                      },
                      child: Text(
                        'Check out'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabs {
  final String? title;
  bool? isSelected;

  Tabs({
    this.title,
    this.isSelected,
  });
}

