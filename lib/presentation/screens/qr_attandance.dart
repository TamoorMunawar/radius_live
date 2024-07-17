import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as m;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/presentation/cubits/events/initial_events/initial_event_cubit.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/cubits/zone/zone_cubit.dart';
import 'package:radar/presentation/cubits/zone_seats/zone_seats_cubit.dart';

import 'package:radar/presentation/screens/events.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class QrAttandanceScreen extends StatefulWidget {
  const QrAttandanceScreen({super.key});

  @override
  State<QrAttandanceScreen> createState() => _QrAttandanceScreenState();
}

class _QrAttandanceScreenState extends State<QrAttandanceScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  String removeHtmlTags(String htmlString) {
    final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);

    return htmlString.replaceAll(regExp, '');
  }

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
  late ZoneSeatsCubit zoneSeatsCubit;
  late ZoneCubit zoneCubit;
  String? roleName;
  bool showAlert = false;
  final alertFormKey = GlobalKey<FormState>();
  Zone? zoneValue;

  int? checkInEventModelId = 0;

  int? checkOutEventModelId = 0;

  bool isCheckInValue = false;
  InitialEvent? _initialEvent;

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

  @override
  void initState() {
    scanQrCodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);
    zoneCubit = BlocProvider.of<ZoneCubit>(context);
    initialEventCubit = BlocProvider.of<InitialEventCubit>(context);
    // zoneSeatsCubit = BlocProvider.of<ZoneSeatsCubit>(context);
    checkInScrollController.addListener(_checkInScrollListener);
    checkOutScrollController.addListener(_finalScrollListener);
    determinePosition();
    getUserDetailsFromLocal();

    getFinalEventData();
    //  initialEventCubit.getFinalEvent(page: finalCount);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // scanQrCodeCubit.close();
    // zoneCubit.close();
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //GlobalColors.backgroundColor,
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
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.height(context, 0.02),
                    bottom: SizeConfig.height(context, 0.02),
                    left: SizeConfig.width(context, 0.05),
                    right: SizeConfig.width(context, 0.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return GestureDetector(
                      onTap: () async {
                        for (var element in tabList) {
                          element.isSelected = false;
                        }
                        setState(() {
                          tabList[index].isSelected = true;
                          showAlert = false;
                          finalCount = 1;
                          count = 1;
                          finalEventList.clear();
                          finalEventList = [];
                          zoneValue = null;
                          //   isLoadingMoreCheckout=true;
                        });
                        getFinalEventData();
                      },
                      child: Container(
                        height: SizeConfig.height(context, 0.05),
                        width: SizeConfig.width(context, 0.45),
                        decoration: BoxDecoration(
                          color: tabList[index].isSelected ?? false
                              ? const Color(0xFFEF4A4A)
                              : GlobalColors.submitButtonTextColor,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.width(context, 0.02),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          tabList[index].title ?? "",
                          style: TextStyle(
                              color: tabList[index].isSelected ?? false
                                  ? const Color(
                                      0xFF0D0D0D,
                                    )
                                  : GlobalColors.submitButtonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.width(context, 0.03)),
                        )),
                      ),
                    );
                  }),
                ),
              ),
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
                      : (tabList.first.isSelected ?? false)
                          ? Expanded(
                              child: ListView.separated(
                                //   primary: true,
                                // shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: SizeConfig.height(context, 0.1)),
                                controller: checkOutScrollController,
                                itemBuilder: (context, index) {
                                  var item = finalEventList.elementAt(index);
                                  if (index < finalEventList.length) {
                                    return EventsTab(
                                      onTap: () async {
                                        setState(() {
                                          showAlert = true;
                                          checkInEventModelId = item.id;
                                          isCheckInValue = true;
                                          _initialEvent = item;
                                        });
                                        zoneCubit.getZone(eventId: item.id);
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
                                itemCount: (isLoadingMoreCheckout)
                                    ? finalEventList.length ?? 0 + 1
                                    : finalEventList.length ?? 0,
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
                                          isCheckInValue = false;
                                        });
                                        zoneCubit.getZone(eventId: item.id);
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
                                itemCount: (isLoadingMoreCheckout)
                                    ? finalEventList?.length ?? 0 + 1
                                    : finalEventList?.length ?? 0,
                              ),
                            )
            ],
          ),
          (showAlert)
              ? buildAlertWidget(context: context, isCheckIn: isCheckInValue, event: _initialEvent)
              : Container(),
          BlocListener<ScanQrCodeCubit, ScanQrCodeState>(
            listener: (context, state) {
              if (state is ScanQrcodeSuccess) {
                AppUtils.showFlushBar("Attandance Marked Successfully".tr(), context);
              }
              if (state is ScanQrcodeFailure) {
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
            color: GlobalColors.backgroundColor, borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02))),
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
                "Zone".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.width(context, 0.04),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Material(
                color: Colors.transparent,
                shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                child: BlocConsumer<ZoneCubit, ZoneState>(
                  builder: (context, state) {
                    if (state is ZoneLoading) {
                      return const LoadingWidget();
                    }
                    if (state is ZoneSuccess) {
                      return DropdownButtonFormField<Zone>(
                        isExpanded: true,
                        dropdownColor: GlobalColors.backgroundColor,
                        padding: const EdgeInsets.only(),
                        items: state.result.map((Zone item) {
                          return DropdownMenuItem<Zone>(
                            value: item,
                            child: Text(
                              item.categoryName ?? "",
                              style: TextStyle(color: GlobalColors.textFieldHintColor),
                            ),
                          );
                        }).toList(),
                        value: zoneValue,
                        onChanged: (value) {
                          setState(() {
                            zoneValue = value;
                            print("zone id ${zoneValue?.id} ");
                          });
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Select Zone'.tr(),
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
                            return 'Please select a Zone';
                          }
                          return null;
                        },
                      );
                    }
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is ZoneFailure) {
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                  },
                ),
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
              (isCheckInValue)
                  ? SubmitButton(
                      gradientFirstColor: const Color(0xFFC1954A),
                      width: SizeConfig.width(context, 0.85),
                      onPressed: () async {
                        bool isWithinRadius = _checkIfWithinRadius(
                            zoneLat: event.latitude, zoneLong: event.longitude, zonRadius: event.radius);
                        if (zoneValue == null) {
                          AppUtils.showFlushBar("Please select a Zone".tr(), context);
                          return;
                        }
                        if (!isWithinRadius) {
                          AppUtils.showFlushBar("You are not in the Zone", context);

                          return;
                        }
                        if (roleName == "Usher" || roleName == "Client") {
                          AppUtils.showFlushBar("You don't have permission to marked the Attandance".tr(), context);
                          return;
                        }
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SimpleBarcodeScannerPage(),
                            ));
                        print("resssssv $res");
                        var response = jsonDecode(res);
                        ScanQrCodePayload qrcodeResult = ScanQrCodePayload.fromJson(response);
                        print("resssssvisCheckInValue ${isCheckInValue}");
                        qrcodeResult.type = (isCheckInValue) ? "checkIn" : "CheckOut";
                        print("ScanQrCodePayload ${qrcodeResult.name}");
                        print("ScanQrCodePayload ${qrcodeResult.id}");
                        print("ScanQrCodePayload ${qrcodeResult.id}");
                        if (qrcodeResult?.name?.isNotEmpty ?? false) {
                          scanQrCodeCubit.scanQrCodeByEventId(
                            isCheckout: (isCheckInValue) ? false : true,
                            eventModelId: (isCheckInValue) ? checkInEventModelId : checkOutEventModelId,
                            zoneId: zoneValue?.id,
                            latitude: latitude,
                            longitude: longitude,
                            scanQrCodePayload: qrcodeResult,
                            userId: qrcodeResult.id,
                          );
                        }
                        setState(() {
                          showAlert = false;
                          zoneValue = null;
                        });
                        //  Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                      },
                      child: Text(
                        (isCheckInValue) ? 'Check In'.tr() : 'Check out'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                  : SubmitButton(
                      gradientFirstColor: const Color(0xFFC1954A),
                      width: SizeConfig.width(context, 0.85),
                      onPressed: () async {
                        print("ssss");
                        if (zoneValue == null) {
                          AppUtils.showFlushBar("Please select a Zone".tr(), context);
                          return;
                        }
                        if (roleName == "Usher" || roleName == "Client") {
                          AppUtils.showFlushBar("You don't have permission to marked the Attandance".tr(), context);
                          return;
                        }
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SimpleBarcodeScannerPage(),
                            ));
                        print("resssssv $res");
                        var response = jsonDecode(res);
                        ScanQrCodePayload qrcodeResult = ScanQrCodePayload.fromJson(response);
                        print("resssssvisCheckInValue ${isCheckInValue}");
                        qrcodeResult.type = (isCheckInValue) ? "checkIn" : "CheckOut";
                        print("ScanQrCodePayload ${qrcodeResult.name}");
                        print("ScanQrCodePayload ${qrcodeResult.id}");
                        print("ScanQrCodePayload ${qrcodeResult.id}");
                        if (qrcodeResult?.name?.isNotEmpty ?? false) {
                          scanQrCodeCubit.scanQrCodeByEventId(
                            isCheckout: (isCheckInValue) ? false : true,
                            eventModelId: (isCheckInValue) ? checkInEventModelId : checkOutEventModelId,
                            zoneId: zoneValue?.id,
                            latitude: latitude,
                            longitude: longitude,
                            scanQrCodePayload: qrcodeResult,
                            userId: qrcodeResult.id,
                          );
                        }
                        setState(() {
                          showAlert = false;
                          zoneValue = null;
                        });
                        //  Navigator.pushNamed(context, AppRoutes.resetScreenRoute);
                      },
                      child: Text(
                        (isCheckInValue) ? 'Check In'.tr() : 'Check out'.tr(),
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      )),
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
