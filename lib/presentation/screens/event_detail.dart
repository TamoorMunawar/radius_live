import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/constants/strings.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';
import 'package:radar/domain/entities/events/event_detail/Job.dart';
import 'package:radar/presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';
import 'package:radar/presentation/cubits/events/event_detail/event_detail_cubit.dart';

import 'package:radar/presentation/screens/create_job_screen.dart';
import 'package:radar/presentation/screens/create_zone_screen.dart';
import 'package:radar/presentation/screens/dashboard_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../constants/app_utils.dart';

import '../../domain/entities/events/event_detail/GetZone.dart';
import '../../domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import '../cubits/accept_Invitation/accept_invitation_cubit.dart';
import '../cubits/zone/zone_cubit.dart';

class EventDetilsScreen extends StatefulWidget {
  const EventDetilsScreen({super.key, required this.args});

  final EventDetailScreenArgs args;

  @override
  State<EventDetilsScreen> createState() => _EventDetilsScreenState();
}

class _EventDetilsScreenState extends State<EventDetilsScreen> {
  double latitude = 25.3960;
  double longitude = 68.3578;
  int? checkInEventModelId = 0;
  bool _isChecked = false;

  int? checkOutEventModelId = 0;
  late EventDetailCubit eventDetailCubit;
  late ZoneCubit zoneCubit;
  late AcceptInvitationCubit acceptInvitationCubit;
  String address = "";
  String? roleName;
  String? eventImagePath;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  String removeHtmlTags(String htmlString) {
    final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);

    return htmlString.replaceAll(regExp, '');
  }

  final alertFormKey = GlobalKey<FormState>();
  Zone? zoneValue;
  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    eventImagePath = prefs.getString("event_image_path") ?? "";
    roleName = prefs.getString(
          "role_name",
        ) ??
        "";
    print("role name $roleName");
    setState(() {});
  }

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 12,
  );
  bool showAlert = false;

  bool isCheckInValue = false;
  String currentLocation = '';
  GoogleMapController? _googleMapController;
  late ScanQrCodeCubit scanQrCodeCubit;
  @override
  void initState() {
    getUserDetailsFromLocal();
    scanQrCodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);
    eventDetailCubit = BlocProvider.of<EventDetailCubit>(context);
    acceptInvitationCubit = BlocProvider.of<AcceptInvitationCubit>(context);
    eventDetailCubit.getEventDetailById(eventId: widget.args.eventId);
    super.initState();
  }

  EventDetail? eventDetail;

  bool _checkIfExpired() {
    DateTime startTime = DateTime(
      eventDetail!.startDate!.year,
      eventDetail!.startDate!.month,
      eventDetail!.startDate!.day,
      int.parse(eventDetail!.startTime.toString().split(":").first),
      int.parse(eventDetail!.startTime.toString().split(":").last),
    );
    DateTime? expiryTime;
    if (eventDetail!.leadTimeUnit == "hour") {
      expiryTime = startTime.add(Duration(hours: int.parse(eventDetail!.leadTime!)));
    } else if (eventDetail!.leadTimeUnit == "days") {
      expiryTime = startTime.add(Duration(days: int.parse(eventDetail!.leadTime!)));
    }

    String date = DateFormat("yyyy:MM:dd hh:mm a").format(expiryTime!);
    log(date);

    final now = DateTime.now();
    if (now.difference(expiryTime).isNegative) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        //GlobalColors.backgroundColor,
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
          "Event Details".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: SizeConfig.width(context, 0.9),
        height: SizeConfig.height(context, 1),
        margin: EdgeInsets.only(
          top: SizeConfig.height(context, 0.02),
          bottom: SizeConfig.height(context, 0.02),
          left: SizeConfig.width(context, 0.05),
          right: SizeConfig.width(context, 0.05),
        ),
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
        child: BlocConsumer<EventDetailCubit, EventDetailState>(
          listener: (context, state) {
            if (state is EventDetailFailed) {
              AppUtils.showFlushBar(state.errorMessage, context);
            }
            if (state is EventDetailSuccess) {
              eventDetail = state.eventDetail;

              if (eventDetail != null && eventDetail?.latitude != null) {
                print(
                    "latitude from APi ${eventDetail?.latitude} ${double.parse(eventDetail?.latitude.toString() ?? "24.8607")}");
                print(
                    "longitude from APi ${eventDetail?.longitude} ${double.parse(eventDetail?.longitude.toString() ?? "67.0011")}");
                longitude = double.parse(eventDetail?.longitude ?? "67.0011");
                latitude = double.parse(eventDetail?.latitude ?? "24.8607");

                setState(() {});
              }
            }
          },
          builder: (context, state) {
            if (state is EventDetailLoading) {
              return const LoadingWidget();
            }
            if (state is EventDetailSuccess) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildEventLogo(
                            context: context,
                            leadTime: "${eventDetail?.leadTime}",
                            logo: "$eventImagePath${eventDetail?.logo}",
                            isExpired: _checkIfExpired()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.eventName == null)
                                ? Container()
                                : TitleAndNameWidget(title: "English Name".tr(), subtitle: "${eventDetail?.eventName}"),
                            (eventDetail?.eventName == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Arabic Name".tr(), subtitle: "${eventDetail?.eventName}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.country?.name == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Country".tr(), subtitle: "${eventDetail?.country?.name}"),
                            TitleAndNameWidget(title: "City".tr(), subtitle: "${eventDetail?.cityId}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (eventDetail?.district == null)
                                ? Container()
                                : TitleAndNameWidget(title: "District".tr(), subtitle: "${eventDetail?.district}"),
                          ],
                        ),
                        Container(
                          //color: Colors.blue,
                          height: SizeConfig.height(context, 0.2),
                          width: SizeConfig.width(context, 0.8),
                          child: Center(
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(target: LatLng(latitude, longitude), zoom: 14),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("home123123123"),
                                  position: LatLng(latitude, longitude),
                                  infoWindow: InfoWindow(title: 'Event  Location'.tr()),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                                ),
                              },
                              onMapCreated: (GoogleMapController controller) {
                                //   _controller.complete(controller);
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.formatStartDate == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    title: "Date From".tr(), maxLine: 2, subtitle: "${eventDetail?.formatStartDate}"),
                            (eventDetail?.formatEndDate == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    maxLine: 2, title: "Date To".tr(), subtitle: "${eventDetail?.formatEndDate}"),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.startTime == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Start in".tr(), subtitle: "${eventDetail?.startTime}"),
                            (eventDetail?.endTime == null)
                                ? Container()
                                : TitleAndNameWidget(title: "End in".tr(), subtitle: "${eventDetail?.endTime}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.manager?.name == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    title: "Event Manager".tr(), subtitle: "${eventDetail?.manager?.name}"),
                            (eventDetail?.leadTimeUnit == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    title: "Lead Time Unit".tr(), subtitle: "${eventDetail?.leadTimeUnit}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.wareHouseManager?.name == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    titleMaxLine: 2,
                                    title: "Warehouse Manager".tr(),
                                    subtitle: "${eventDetail?.wareHouseManager?.name}"),
                            /*   TitleAndNameWidget(
                                title: "Payment Interval", subtitle: "Naperville"),*/
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.leadTime == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Lead Time".tr(), subtitle: "${eventDetail?.leadTime}"),
                            (eventDetail?.location == null)
                                ? Container()
                                : TitleAndNameWidget(
                                    title: "Location Radius".tr(), subtitle: "${eventDetail?.location}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (eventDetail?.latitude == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Latitude".tr(), subtitle: "${eventDetail?.latitude}"),
                            (eventDetail?.longitude == null)
                                ? Container()
                                : TitleAndNameWidget(title: "Longitude".tr(), subtitle: "${eventDetail?.longitude}"),
                          ],
                        ),
                        (eventDetail?.dayoff.toString() == "null" || eventDetail?.dayoff == null)
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TitleAndNameWidget(width: 0.7, title: "Day Off", subtitle: "${eventDetail?.dayoff}"),
                                ],
                              ),
                        /*   Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: SizeConfig.width(
                                  context,
                                  0.040,
                                ),
                                fontWeight: FontWeight.w300,
                                color: GlobalColors.textFieldHintColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: SizeConfig.width(
                                context,
                                0.04,
                              ),
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.01),
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Jobs",
                              style: TextStyle(
                                  fontSize: SizeConfig.width(
                                    context,
                                    0.04,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            (roleName == "Usher" || roleName == "Client")
                                ? Container()
                                : IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRoutes.createJobScreenRoute,
                                          arguments: CreateJobScreenArgs(id: eventDetail?.id ?? 0));
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_sharp,
                                      size: SizeConfig.width(context, 0.06),
                                      color: Colors.white,
                                    ))
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                eventDetail?.eventZonesAll?.length ?? 0,
                                // eventDetail?.eventZonesAll?.length ?? 0,
                                (index) => JobWidget(
                                  eventDetail: eventDetail ?? EventDetail(id: 0),
                                  eventId: widget.args.eventId,
                                  job: eventDetail?.eventZonesAll?[index].job ?? Job(),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.02),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Zones".tr(),
                              style: TextStyle(
                                  fontSize: SizeConfig.width(
                                    context,
                                    0.045,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            (roleName == "Usher" || roleName == "Client")
                                ? Container()
                                : IconButton(
                                    onPressed: () {
                                      print("sdfsmdnfsdfnsndf,mnsmdnf");
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.createZoneScreenRoute,
                                        arguments: CreateZoneScreenArgs(
                                          eventId: widget.args.eventId,
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_sharp,
                                      size: SizeConfig.width(context, 0.06),
                                      color: Colors.white,
                                    ))
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.02),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                eventDetail?.eventZonesAll?.length ?? 0,
                                // eventDetail?.eventZonesAll?.length ?? 0,
                                (index) => ZonesWidget(
                                  eventDetail: eventDetail ?? EventDetail(id: 0),
                                  eventId: widget.args.eventId,
                                  getZone: eventDetail?.eventZonesAll?[index].getZone ?? GetZone(id: 0),
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Summary".tr(),
                              style: TextStyle(
                                  fontSize: SizeConfig.width(
                                    context,
                                    0.045,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                removeHtmlTags(eventDetail?.projectSummary ?? ""),
                                style: TextStyle(
                                  fontSize: SizeConfig.width(
                                    context,
                                    0.040,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        (eventDetail?.manager?.name == null)
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"Event Manager".tr()} : ${eventDetail?.manager?.name}",
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: SizeConfig.width(
                                          context,
                                          0.032,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                        (widget.args.finalInvitation || _checkIfExpired())
                            ? Container()
                            : buildCheckBoxWidget(
                                context: context,
                                checkValue: _isChecked,
                                title: "I_am_accepting_the".tr(),
                                onChange: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                }),
                        SizedBox(
                          height: SizeConfig.height(context, 0.02),
                        ),
                        (widget.args.finalInvitation && roleName != "Usher" && roleName != "Client")
                            ? SubmitButton(
                                gradientFirstColor: GlobalColors.submitButtonColor,
                                width: SizeConfig.width(context, 0.85),
                                onPressed: () async {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.scanQrcodeForUsherInviteScreenRoute,
                                    arguments: UsherInviteScreenArgs(
                                      eventId: widget.args.eventId,
                                      finalInvitation: false,
                                      eventZoneAll: eventDetail?.eventZonesAll ?? [],
                                    ),
                                  );
                                },
                                child: Text(
                                  'Invite Usher'.tr(),
                                  style: TextStyle(
                                    color: GlobalColors.submitButtonTextColor,
                                    fontSize: SizeConfig.width(context, 0.04),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(),
                        (widget.args.finalInvitation || _checkIfExpired())
                            ? Container()
                            : SubmitButton(
                                gradientFirstColor: const Color(0xFFEF4A4A).withOpacity(0.2),
                                width: SizeConfig.width(context, 0.9),
                                onPressed: () async {
                                  if (!_isChecked) {
                                    AppUtils.showFlushBar(
                                      "Terms_and_Condition".tr(),
                                      context,
                                    );
                                    return;
                                  }
                                  int.parse(eventDetail?.leadTime ?? "0");
                                  int time = int.parse(eventDetail?.leadTime ?? "0") ?? 0;
                                  log("sddddddddddddd ${int.parse(eventDetail?.leadTime ?? "0")}");
                                  if (time > 0) {
                                    acceptInvitationCubit.acceptInvitation(status: 1, eventId: widget.args.eventId);
                                  } else {
                                    AppUtils.showFlushBar(
                                      "Event is Expired".tr(),
                                      context,
                                    );
                                  }
                                },
                                child: BlocConsumer<AcceptInvitationCubit, AcceptInvitationState>(
                                  listener: (context, state) {
                                    log("state AcceptInvitation state $state");

                                    if (state is AcceptInvitationFailed) {}
                                    if (state is AcceptInvitationSuccess) {
                                      isJobAccepted = true;
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, AppRoutes.pagesScreenRoute, (route) => false,
                                          arguments: 2);
                                      AppUtils.showFlushBar("Job Accept Successfully".tr(), context);
                                      //    Navigator.pop(context);

                                      /*    Navigator.pushReplacementNamed(
                                    context, AppRoutes.pagesScreenRoute,
                                    arguments: 2);*/
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AcceptInvitationLoading) {
                                      return const LoadingWidget();
                                    }
                                    return Text(
                                      'Accept Job'.tr(),
                                      style: TextStyle(
                                        color: const Color(0xFFEF4A4A),
                                        fontSize: SizeConfig.width(context, 0.04),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.01),
                        ),
                        (widget.args.finalInvitation || _checkIfExpired())
                            ? Container()
                            : SubmitButton(
                                gradientFirstColor: const Color(0xFFEF4A4A).withOpacity(0.2),
                                width: SizeConfig.width(context, 0.9),
                                onPressed: () async {
                                  acceptInvitationCubit.declineInvitation(status: 0, eventId: widget.args.eventId);
                                },
                                child: BlocConsumer<AcceptInvitationCubit, AcceptInvitationState>(
                                  listener: (context, state) {
                                    print("state AcceptInvitation state $state");
                                    if (state is DeclineInvitationFailed) {
                                      AppUtils.showFlushBar(state.errorMessage, context);
                                    }
                                    if (state is DeclineInvitationSuccess) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, AppRoutes.pagesScreenRoute, (route) => false,
                                          arguments: 2);
                                      AppUtils.showFlushBar("Job Decline Successfully".tr(), context);
                                      //    Navigator.pop(context);

                                      /*    Navigator.pushReplacementNamed(
                                    context, AppRoutes.pagesScreenRoute,
                                    arguments: 2);*/
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is DeclineInvitationLoading) {
                                      return const LoadingWidget();
                                    }
                                    return Text(
                                      'Decline Job'.tr(),
                                      style: TextStyle(
                                        color: const Color(0xFFEF4A4A),
                                        fontSize: SizeConfig.width(context, 0.04),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(
                          height: SizeConfig.height(context, 0.01),
                        ),
                      ],
                    ),
                    /* (showAlert)
                        ? buildAlertWidget(context: context, isCheckIn: isCheckInValue)
                        : Container(),
                    BlocListener<ScanQrcodeCubit, ScanQrcodeState>(
                      listener: (context, state) {
                        if (state is ScanQrcodeSuccess) {
                          AppUtils.showFlushBar("Attandance Marked Successfully", context);
                        }
                        if (state is ScanQrcodeFailure) {
                          AppUtils.showFlushBar(state.errorMessage, context);
                        }
                      },
                      child: Container(),
                    )*/
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildCheckBoxWidget(
      {required BuildContext context,
      required String title,
      required bool checkValue,
      required void Function(bool?) onChange}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(context, 0.07)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Noto Sans",
                    color: GlobalColors.hintTextColor,
                    fontSize: SizeConfig.width(context, 0.03),
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  _showTermsDialog(context);
                },
                child: Text(
                  "Terms_and_Condition".tr(),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontFamily: "Noto Sans",
                      color: GlobalColors.hintTextColor,
                      fontSize: SizeConfig.width(context, 0.025),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Checkbox(
              side: const BorderSide(color: Colors.grey),
              checkColor: GlobalColors.submitButtonColor,
              fillColor: MaterialStateProperty.all<Color>(Colors.white),
              value: checkValue,
              onChanged: onChange),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalColors.backgroundColor,
          title: Text(
            'شروط واحكام',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white, fontSize: SizeConfig.width(context, 0.05)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  Strings.termsAndConditionsText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.width(context, 0.03),
                  ),
                ),
                // Add more text here to elaborate on your terms and conditions
              ],
            ),
          ),
          actions: <Widget>[
            /*    TextButton(
              child: Text('Disagree'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),*/
            TextButton(
              child: Text('Agree'.tr()),
              onPressed: () {
                // Code to execute when the user agrees with terms and conditions
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Align buildAlertWidget({required BuildContext context, required bool isCheckIn}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: GlobalColors.backgroundColor, borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02))),
        height: SizeConfig.height(context, 0.3),
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
                            setState(() => zoneValue = value);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Select Zone'.tr(),
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
                              return 'Please select a Department'.tr();
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
                  height: SizeConfig.height(context, 0.03),
                ),
                SubmitButton(
                  gradientFirstColor: GlobalColors.submitButtonColor,
                  width: SizeConfig.width(context, 0.85),
                  onPressed: () async {
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildEventLogo({required BuildContext context, String? leadTime, String? logo, required bool isExpired}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (logo == null)
            ? CircleAvatar(
                backgroundImage: const AssetImage("assets/icons/Event.png"),
                radius: SizeConfig.width(context, 0.09),
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(logo),
                radius: SizeConfig.width(context, 0.09),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*  InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutes.attandanceDetailScreenRoute);
              },
              child: Image.asset(
                "assets/icons/message_icon.png",
                width: SizeConfig.width(context, 0.05),
              ),
            ),*/
            SizedBox(
              width: SizeConfig.width(context, 0.04),
            ),
            Container(
              //alignment: Alignment.center,
              // height: SizeConfig.height(context, 0.07),
              width: SizeConfig.width(context, 0.3),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context, 0.03),
                vertical: isExpired ? SizeConfig.height(context, 0.03) : 0,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xFF57FF491A),
                  borderRadius: BorderRadius.circular(SizeConfig.width(context, 0.02))),
              child: isExpired
                  ? Text(
                      "Expired",
                      style: TextStyle(color: const Color(0xFF57FF49), fontSize: SizeConfig.width(context, 0.03)),
                    )
                  : ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${"Lead Time".tr()} :",
                        style: TextStyle(color: const Color(0xFF57FF49), fontSize: SizeConfig.width(context, 0.03)),
                      ),
                      subtitle: Text(
                        "$leadTime ${eventDetail?.leadTimeUnit}",
                        style: TextStyle(color: const Color(0xFF57FF49), fontSize: SizeConfig.width(context, 0.03)),
                      ),
                    ),
            )
          ],
        )
      ],
    );
  }
}

class JobWidget extends StatelessWidget {
  const JobWidget({
    super.key,
    required this.job,
    required this.eventId,
    required this.eventDetail,
  });

  final Job? job;
  final EventDetail eventDetail;
  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        color: GlobalColors.primaryColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.width(context, 0.02),
        ),
      ),
      // height: SizeConfig.height(context, 0.4),
      width: SizeConfig.width(context, 0.6),
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height(context, 0.02),
        horizontal: SizeConfig.width(context, 0.03),
      ),
      margin: EdgeInsets.only(
        right: SizeConfig.width(context, 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.createZoneScreenRoute,
                  arguments: CreateZoneScreenArgs(eventId: eventId));
            },
            child: Text(
              "${job?.name}",
              style: TextStyle(
                  fontSize: SizeConfig.width(
                    context,
                    0.045,
                  ),
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          (job?.totalMaleSalary == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(title: "Total Male Salary".tr(), subtitle: "${job?.totalMaleSalary}"),
                  ],
                ),
          (job?.dailyMaleSalary == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(title: "Daily Male Salary".tr(), subtitle: "${job?.dailyMaleSalary}"),
                  ],
                ),
          (job?.description == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(
                        width: 0.48,
                        height: 0.12,
                        maxLine: 5,
                        title: "Description".tr(),
                        subtitle: "${job?.description}"),
                  ],
                ),
        ],
      ),
    );
  }
}

class ZonesWidget extends StatelessWidget {
  const ZonesWidget({
    super.key,
    required this.getZone,
    required this.eventId,
    required this.eventDetail,
  });

  final GetZone getZone;
  final EventDetail eventDetail;
  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.primaryColor,
        borderRadius: BorderRadius.circular(
          SizeConfig.width(context, 0.02),
        ),
      ),
      //  height: SizeConfig.height(context, 0.3),
      width: SizeConfig.width(context, 0.6),
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height(context, 0.02),
        horizontal: SizeConfig.width(context, 0.03),
      ),
      margin: EdgeInsets.only(
        right: SizeConfig.width(context, 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.createZoneScreenRoute,
                  arguments: CreateZoneScreenArgs(eventId: eventId));
            },
            child: Text(
              "${getZone.categoryName}",
              style: TextStyle(
                  fontSize: SizeConfig.width(
                    context,
                    0.045,
                  ),
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          (eventDetail.manager?.name == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(title: "Supervisior".tr(), subtitle: "${eventDetail.manager?.name}"),
                  ],
                ),
          (getZone.location == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(title: "Location".tr(), subtitle: "${getZone.location}"),
                  ],
                ),
          (getZone.description == null)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndNameWidget(
                        width: 0.48,
                        height: 0.12,
                        maxLine: 3,
                        title: "Description".tr(),
                        subtitle: "${getZone.description}"),
                  ],
                ),
        ],
      ),
    );
  }
}

class TitleAndNameWidget extends StatelessWidget {
  const TitleAndNameWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.height,
    this.maxLine,
    this.titleMaxLine,
    this.width,
    this.color,
  });

  final String title;
  final String subtitle;
  final double? height;
  final double? width;
  final int? maxLine;
  final int? titleMaxLine;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      //  color: Colors.red,
      height: SizeConfig.height(context, height ?? 0.08),
      width: SizeConfig.width(context, width ?? 0.38),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          maxLines: titleMaxLine ?? 1,
          style: TextStyle(
            fontSize: SizeConfig.width(
              context,
              0.040,
            ),
            fontWeight: FontWeight.w300,
            color: GlobalColors.textFieldHintColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          // textAlign: TextAlign.left,
          maxLines: maxLine ?? 1,
          style: TextStyle(
            fontSize: SizeConfig.width(
              context,
              0.04,
            ),
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
