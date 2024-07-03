import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/outside_event_usher/outside_event_usher.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/presentation/cubits/ushers/usher_cubit.dart';
import 'package:radar/presentation/cubits/zone/zone_cubit.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class UsherListByEventScreen extends StatefulWidget {
  const UsherListByEventScreen({super.key, required this.eventId});

  final int eventId;

  @override
  State<UsherListByEventScreen> createState() => _UsherListByEventScreenState();
}

class _UsherListByEventScreenState extends State<UsherListByEventScreen> {
  late UsherCubit usherCubit;

  //late ZoneCubit zoneCubit;
  Zone? zoneValue;
  String searchText = '';
  bool isLoadingMore = false;
  int count = 1;
  bool isZoneSelected = false;

  Future _initialScrollListener() async {
    if (isLoadingMore) return;
    if (initialScrollController.position.pixels ==
        initialScrollController.position.maxScrollExtent) {
      print("if scroll listener called");
      setState(() {
        isLoadingMore = true;
      });
      count = count + 1;

      usherList.addAll(await usherCubit.getUsherByEvent(
          eventId: widget.eventId, page: count));
    }
    setState(() {
      isLoadingMore = false;
    });
  }

  final initialScrollController = ScrollController();
  List<OutsideEventUsher> usherList = [];

  getdata() async {
    setState(() {
      isLoadingMore = true;
    });
    usherList = await usherCubit.getUsherByEvent(
      eventId: widget.eventId,
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

    initialScrollController.addListener(_initialScrollListener);
    //usherCubit.getUsher(isZoneSelected: false, page: count);
    getdata();
    // TODO: implement initState
    super.initState();
  }

  List<OutsideEventUsher> foundUshersList = [];

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //zoneCubit.close();
    // usherCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    print("usher List length ${usherList.length}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //GlobalColors.backgroundColor,
        centerTitle: true,

        leading: IconButton(
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
        ),
        title: Text(
          "Outside Usher".tr(),
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
                      List<OutsideEventUsher> results = [];
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
                                  (dH.iqamaId
                                          ?.toLowerCase()
                                          .contains(value.toLowerCase()) ??
                                      false) ||
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
                          print(
                              "foundUshersList $foundUshersList ${foundUshersList.length}");
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.height(context, 0.2)),
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
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.height(context, 0.1)),
                      controller: initialScrollController,
                      separatorBuilder: (context, index) {
                        return buildDividerWidget(
                            context: context,
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width(context, 0.05),
                              vertical: SizeConfig.height(context, 0.015),
                            ));
                      },
                      itemBuilder: (context, index) {
                        var item = foundUshersList.elementAt(index);
                        if (index < foundUshersList!.length) {
                          return Container(
                            //  height: SizeConfig.height(context, 0.135),
                            width: SizeConfig.width(context, 0.9),
                            margin: EdgeInsets.only(
                              //  top: SizeConfig.height(context, 0.02),
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
                                      backgroundImage:
                                          NetworkImage(item.imageUrl ?? ""),
                                      radius: SizeConfig.width(context, 0.08),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.width(context, 0.03),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      width: SizeConfig.width(context, 0.55),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name ?? "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig.width(
                                                  context, 0.032),
                                            ),
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: "Email".tr(),
                                              style: TextStyle(
                                                color: GlobalColors
                                                    .textFieldHintColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: SizeConfig.width(
                                                    context, 0.032),
                                              ),
                                            ),
                                            TextSpan(
                                              text: ":  ${item.email}",
                                              style: TextStyle(
                                                color: GlobalColors
                                                    .textFieldHintColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: SizeConfig.width(
                                                    context, 0.032),
                                              ),
                                            ),
                                          ])),
                                          Text(
                                            "${item.alertMessage}",
                                            style: TextStyle(
                                              color: GlobalColors
                                                  .submitButtonColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig.width(
                                                  context, 0.032),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                      itemCount: (isLoadingMore)
                          ? foundUshersList.length
                          : foundUshersList.length,
                    ))
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
