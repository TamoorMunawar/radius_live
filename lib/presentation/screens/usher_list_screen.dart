import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/presentation/cubits/ushers/usher_cubit.dart';
import 'package:radar/presentation/cubits/zone/zone_cubit.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/ushers/Department.dart';

class UsherListScreen extends StatefulWidget {
  const UsherListScreen({super.key});

  @override
  State<UsherListScreen> createState() => _UsherListScreenState();
}

class _UsherListScreenState extends State<UsherListScreen> {
  late UsherCubit usherCubit;
  late ZoneCubit zoneCubit;
  Zone? zoneValue;
  String searchText = '';
  bool isLoadingMore = false;
  int count = 1;
  bool isZoneSelected = false;

  Future _initialScrollListener() async {
    if (isLoadingMore) return;
    if (initialScrollController.position.pixels == initialScrollController.position.maxScrollExtent) {
      print("if scroll listener called");
      setState(() {
        isLoadingMore = true;
      });
      count = count + 1;

      usherList.addAll(await usherCubit.getUsher(zoneId: zoneValue?.id, isZoneSelected: isZoneSelected, page: count));
    }
    setState(() {
      isLoadingMore = false;
    });
  }

  final initialScrollController = ScrollController();
  List<Ushers> usherList = [];

  getdata() async {
    setState(() {
      isLoadingMore = true;
    });
    usherList = await usherCubit.getUsher(
      isZoneSelected: isZoneSelected,
      page: count,
    );
    setState(() {
      foundUshersList = usherList;
      isLoadingMore = false;
    });
  }

  @override
  void initState() {
    usherCubit = BlocProvider.of<UsherCubit>(context);
    zoneCubit = BlocProvider.of<ZoneCubit>(context);
    zoneCubit.getZoneByUserId(isAddElement: true);
    initialScrollController.addListener(_initialScrollListener);
    //usherCubit.getUsher(isZoneSelected: false, page: count);
    getdata();
    // TODO: implement initState
    super.initState();
  }
// Helper method to format the check-in time
  String _formatCheckInTime(String? checkInTime) {
    if (checkInTime == null) {
      return "N/A";
    }
    try {
      DateTime parsedDate = DateTime.parse(checkInTime);
      // Include AM/PM in the format
      return DateFormat('yyyy-MM-dd hh:mm a').format(parsedDate);
    } catch (e) {
      return "Invalid date";
    }
  }
  List<Ushers> foundUshersList = [];

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //   zoneCubit.close();
    // usherCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    print("usher List length ${usherList.length}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Ushers".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(
              context,
              0.05,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<ZoneCubit, ZoneState>(
            builder: (context, state) {
              if (state is ZoneLoading) {
                return LoadingWidget();
              }
              if (state is ZoneSuccess) {
                return DropdownButtonFormField<Zone>(
                  //isDense: true,

                  isExpanded: true,
                  dropdownColor: GlobalColors.backgroundColor,
                  padding: EdgeInsets.only(
                    left: SizeConfig.width(context, 0.05),
                    right: SizeConfig.width(context, 0.05),
                  ),
                  items: state.result.map((Zone item) {
                    return DropdownMenuItem<Zone>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: item.categoryName ?? "",
                                  style: TextStyle(color: GlobalColors.textFieldHintColor),
                                ),
                                TextSpan(
                                  text: " | ",
                                  style: TextStyle(color: Colors.amber), // Set the color to golden here
                                ),
                                TextSpan(
                                  text: item.invitationCount.toString() ?? "",
                                  style: TextStyle(color: GlobalColors.textFieldHintColor),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "${item.suppervisor}",
                            style: TextStyle(color: GlobalColors.textFieldHintColor, overflow: TextOverflow.clip),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  value: zoneValue,
                  onChanged: (value) async {
                    setState(() {
                      searchController.clear();
                      usherList.clear();
                      foundUshersList.clear();
                      zoneValue = value;
                      count = 1;
                      isZoneSelected = true;
                      isLoadingMore = true;
                    });

                    if (zoneValue?.id == 0) {
                      isZoneSelected = false;
                      usherList.addAll(await usherCubit.getUsher(
                        zoneId: zoneValue?.id,
                        isZoneSelected: false,
                        page: count,
                      ));
                      foundUshersList = usherList;
                      /*   usherCubit.getUsherTest(
                          isZoneSelected: isZoneSelected, page: count);*/
                    } else {
                      usherList.addAll(await usherCubit.getUsher(
                          isZoneSelected: isZoneSelected, zoneId: zoneValue?.id, page: count));
                      foundUshersList = usherList;
                    }
                    setState(() {
                      isLoadingMore = false;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context, 0.02),
                      vertical: SizeConfig.height(context, 0.012),
                    ),
                    filled: false,
                    hintText: 'Select Zone'.tr(),
                    hintStyle: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: GlobalColors.whiteColor
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: GlobalColors.whiteColor
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: GlobalColors.whiteColor
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: GlobalColors.whiteColor
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.whiteColor,
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
                      return 'Please select a Zone'.tr();
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
          (usherList.isEmpty)
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.height(context, 0.02),
                    left: SizeConfig.width(context, 0.05),
                    right: SizeConfig.width(context, 0.05),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    // focusNode: focusNode,
                    decoration: InputDecoration(
                      filled: false,
                      //    enabled: widget.readOnly??true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                          // width: SizeConfig.width(context, 0.005),
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.hintTextColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.width(context, 0.02),
                        ),
                      ),
                      // suffixIcon: const Icon(Icons.search),
                      hintText: 'Search name or iqama Id'.tr(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: GlobalColors.textFieldHintColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context, 0.05),
                        vertical: SizeConfig.height(context, 0),
                      ),
                    ),
                    onChanged: (String value) {
                      searchText = value;
                      List<Ushers> results = [];
                      if (value.isEmpty) {
                        results = usherList;
                      } else {
                        results = usherList
                            .where(
                              (dH) =>
                                  (dH.name?.toLowerCase().contains(
                                            value.toLowerCase(),
                                          ) ??
                                      false) ||
                                  (dH.iqamaId?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
                                  ("${dH.whatsappNumberCountryCode}${dH.whatsappNumber}"
                                          ?.toLowerCase()
                                          .contains(value.toLowerCase()) ??
                                      false),
                            )
                            .toList();
                      }
                      setState(() {
                        foundUshersList = results;
                        if (kDebugMode) {
                          print("foundUshersList $foundUshersList ${foundUshersList.length}");
                        }
                      });
                    },
                  ),
                ),
          SizedBox(
            height: SizeConfig.height(context, 0.02),
          ),
          (isLoadingMore)
              ? const LoadingWidget()
              : (usherList.isEmpty || foundUshersList.isEmpty)
              ? Center(
            child: Text(
              "No ushers Checkin",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.width(context, 0.032),
              ),
            ),
          )
              : Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: SizeConfig.height(context, 0.1)),
              controller: initialScrollController,
              separatorBuilder: (context, index) {
                return buildDividerWidget(
                  context: context,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context, 0.05),
                    vertical: SizeConfig.height(context, 0.015),
                  ),
                );
              },
              itemBuilder: (context, index) {
                // Filter out items where checkIn is null
                var filteredUshersList =
                foundUshersList.where((item) => item.checkIn != null).toList();
                if (index < filteredUshersList.length) {
                  var item = filteredUshersList.elementAt(index);

                  return InkWell(
                    onTap: () {
                      final args = ReviewScreenArgs(
                        usherId: item.id!,
                        depertmentIdd: item.employeeDetail!.department?.id,
                        depertmentName: item.employeeDetail!.department?.teamName,

                      );
                      Navigator.pushNamed(context, AppRoutes.addReviewScreenRoute, arguments: args);
                    },
                    child: Container(
                      width: SizeConfig.width(context, 0.9),
                      margin: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.05),
                        right: SizeConfig.width(context, 0.05),
                      ),
                      padding: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.01),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(item.imageUrl ?? ""),
                                radius: SizeConfig.width(context, 0.08),
                              ),
                              SizedBox(
                                width: SizeConfig.width(context, 0.03),
                              ),
                              Container(
                                width: SizeConfig.width(context, 0.55),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.width(context, 0.032),
                                      ),
                                    ),
                                    Text(
                                      "Check-In Time: ${_formatCheckInTime(item.checkIn)}",
                                      style: TextStyle(
                                        color: GlobalColors.textFieldHintColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeConfig.width(context, 0.032),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "${"Job".tr()}",
                                          style: TextStyle(
                                            color: GlobalColors.textFieldHintColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: SizeConfig.width(context, 0.032),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ":  ${item.jobName}",
                                          style: TextStyle(
                                            color: GlobalColors.submitButtonColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: SizeConfig.width(context, 0.032),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Handle View Image tap
                                            print("View Image tapped for ${item.jobName}");
                                          },
                                          child: Text(
                                            "View Image",
                                            style: TextStyle(
                                              color: GlobalColors.submitButtonColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig.width(context, 0.032),
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: SizeConfig.width(context, 0.12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (item.mobile == null)
                                        ? Container()
                                        : InkWell(
                                      onTap: () {
                                        makePhoneCall(
                                          phoneNumber: "+${item.countryPhonecode}${item.whatsappNumber}",
                                        );
                                      },
                                      child: Icon(
                                        Icons.call_outlined,
                                        color: Colors.grey,
                                        size: SizeConfig.width(context, 0.07),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    (item.whatsappNumber == null)
                                        ? Container()
                                        : InkWell(
                                      onTap: () {
                                        launchWhatsapp(
                                          phoneNumber: "+${item.countryPhonecode}${item.whatsappNumber}",
                                        );
                                      },
                                      child: Icon(
                                        Icons.messenger_outline_sharp,
                                        color: Colors.grey,
                                        size: SizeConfig.width(context, 0.07),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
              itemCount: foundUshersList.where((item) => item.checkIn != null).length,
            ),
          ),

        ],
      ),
    );
  }

  Future<void> makePhoneCall({String? phoneNumber}) async {
    phoneNumber = phoneNumber ?? '1234567890'; // Specify the phone number here
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  launchWhatsapp({String? phoneNumber}) async {
    var whatsappUrl = "https://wa.me/$phoneNumber";
    var whatsappAndroid = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      AppUtils.showFlushBar("WhatsApp is not installed on the device", context);
    }
  }
}
