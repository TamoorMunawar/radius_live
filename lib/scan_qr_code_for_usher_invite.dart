import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/scan_qr_code/Scan_qr_code_payload.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/presentation/cubits/zone/zone_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'domain/entities/Job.dart';
import 'presentation/cubits/jobs/job_cubit.dart';
import 'presentation/cubits/scan_qr_code/scan_qrcode_cubit.dart';

class ScanQrCodeForUsherInvite extends StatefulWidget {
  const ScanQrCodeForUsherInvite({super.key, required this.args});

  final UsherInviteScreenArgs args;

  @override
  State<ScanQrCodeForUsherInvite> createState() => _ScanQrCodeForUsherInviteState();
}

class _ScanQrCodeForUsherInviteState extends State<ScanQrCodeForUsherInvite> {
  late ZoneCubit zoneCubit;
  Zone? zoneValue;
  Job? jobDropDownValue;
  bool isLoading = false;
  late ScanQrCodeCubit scanQrCodeCubit;
  late JobCubit jobCubit;
  final formKey = GlobalKey<FormState>();
  double latitude = 0.0;
  double longitude = 0.0;
  ScanQrCodeUsherInvitePayload? qrcodeResult;
  ScanQrCodePayload? qrcodeResultData;

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
    print("position.latitude ${position.latitude}");
    print("position.longitude ${position.longitude}");
    latitude = position.latitude;
    longitude = position.longitude;
    setState(() {});
    //return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    determinePosition();
    scanQrCodeCubit = BlocProvider.of<ScanQrCodeCubit>(context);
    zoneCubit = BlocProvider.of<ZoneCubit>(context);
    zoneCubit.getZone(eventId: widget.args.eventId);
    jobCubit = BlocProvider.of<JobCubit>(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.primaryColor,
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
          "Usher Invite",
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
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                      child: BlocConsumer<ZoneCubit, ZoneState>(
                        builder: (context, state) {
                          if (state is ZoneLoading) {
                            return LoadingWidget();
                          }
                          if (state is ZoneSuccess) {
                            return DropdownButtonFormField<Zone>(
                              dropdownColor: GlobalColors.backgroundColor,
                              padding: EdgeInsets.only(),
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
                                  jobDropDownValue = null;
                                  zoneValue = value;
                                });
                                jobCubit.getJob(eventModelId: widget.args.eventId, zoneId: zoneValue?.id, isZone: true);
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Select Zone',
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
                    Material(
                      color: Colors.transparent,
                      shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                      child: BlocConsumer<JobCubit, JobState>(
                        builder: (context, state) {
                          if (state is JobLoading) {
                            return LoadingWidget();
                          }
                          if (state is JobSuccess) {
                            return DropdownButtonFormField<Job>(
                              dropdownColor: GlobalColors.backgroundColor,
                              padding: EdgeInsets.only(),
                              items: state.result.map((Job item) {
                                return DropdownMenuItem<Job>(
                                  value: item,
                                  child: Text(
                                    item.name ?? "",
                                    style: TextStyle(color: GlobalColors.textFieldHintColor),
                                  ),
                                );
                              }).toList(),
                              value: jobDropDownValue,
                              onChanged: (value) {
                                setState(() => jobDropDownValue = value);
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Select Job',
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
                                  return 'Please select a Job';
                                }
                                return null;
                              },
                            );
                          }
                          return Container();
                        },
                        listener: (context, state) {
                          if (state is JobFailure) {
                            AppUtils.showFlushBar(state.errorMessage, context);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.02),
                    ),
                    BlocListener<ScanQrCodeCubit, ScanQrCodeState>(
                      listener: (context, state) {
                        if (state is ScanQrcodeForUsherInviteSuccess) {
                          print("ssssssssssssssssssssssssssssssssdfdfdfdffffffffff");
                          scanQrCodeCubit.scanQrCodeByEventId(
                            latitude: latitude,
                            eventModelId: widget.args.eventId,
                            isCheckout: false,
                            longitude: longitude,
                            zoneId: zoneValue?.id,
                            scanQrCodePayload: qrcodeResultData,
                            userId: qrcodeResult?.id,
                          );
                          if (mounted) {
                            AppUtils.showFlushBar("Usher Invited Successfully", context);
                          }
                        }
                        if (state is ScanQrcodeForUsherInviteFailure) {
                          AppUtils.showFlushBar(state.errorMessage, context);
                        }
                      },
                      child: Container(),
                    ),
                    BlocListener<ScanQrCodeCubit, ScanQrCodeState>(
                      listener: (context, state) {
                        if (state is ScanQrcodeSuccess) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                            AppUtils.showFlushBar("Usher Check In Marked SuccessFully", context);
                          }
                        }
                        if (state is ScanQrcodeFailure) {
                          setState(() {
                            isLoading = false;
                          });
                          AppUtils.showFlushBar(state.errorMessage, context);
                        }
                      },
                      child: Container(),
                    ),
                    SubmitButton(
                      gradientFirstColor: const Color(0xFFC1954A),
                      width: SizeConfig.width(context, 0.85),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (zoneValue == null) {
                            AppUtils.showFlushBar("Please select a Zone".tr(), context);
                            return;
                          }
                          if (jobDropDownValue == null) {
                            AppUtils.showFlushBar("Please select a Job".tr(), context);
                            return;
                          }
                          var result;
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SimpleBarcodeScannerPage(),
                              ));
                          print("resssssv $res");
                          var response = jsonDecode(res);
                          qrcodeResult = ScanQrCodeUsherInvitePayload.fromJson(response);
                          qrcodeResultData = ScanQrCodePayload.fromJson(response);

                          if (kDebugMode) {
                            print("ScanQrCodePayload ${qrcodeResult?.name}");
                          }
                          if (kDebugMode) {
                            print("ScanQrCodePayload ${qrcodeResult?.id}");
                          }
                          if (kDebugMode) {
                            print("ScanQrCodePayload ${qrcodeResult?.id}");
                          }
                          if (qrcodeResult?.name?.isNotEmpty ?? false) {
                            scanQrCodeCubit.scanQrCodeForUsherInvite(
                              eventId: widget.args.eventId,
                              jobId: jobDropDownValue?.id,
                              zoneId: zoneValue?.id,
                              scanQrCodePayload: qrcodeResult,
                            );
                          }
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Invite',
                        style: TextStyle(
                          color: GlobalColors.submitButtonTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child: const CircularProgressIndicator(
                        strokeWidth: 10,
                        color: Colors.white,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
