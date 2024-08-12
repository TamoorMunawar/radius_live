import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/presentation/screens/event_detail_screen.dart';
import 'package:radar/presentation/cubits/events/initial_events/initial_event_cubit.dart';
import 'package:radar/presentation/screens/attandance.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late InitialEventCubit initialEventCubit;
  List<Tabs> tabList = [
    Tabs(
      title: "Initial Invitations".tr(),
      isSelected: true,
    ),
    Tabs(
      title: "Final Invitations".tr(),
      isSelected: false,
    ),
  ];

  bool isInitialList = false;

  String removeHtmlTags(String htmlString) {
    final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);

    return htmlString.replaceAll(regExp, '');
  }

  final initialScrollController = ScrollController();
  final finalScrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoadingMoreFinal = false;
  int count = 1;
  int finalCount = 1;

  Future _initialScrollListener() async {
    if (isLoadingMore) return;
    if (initialScrollController.position.pixels == initialScrollController.position.maxScrollExtent) {
      print("if scroll listener called");
      setState(() {
        isLoadingMore = true;
      });
      count = count + 1;

      initialEventList.addAll(await initialEventCubit.getInitialEventTest(page: count));
    }
    setState(() {
      isLoadingMore = false;
    });
  }

  Future _finalScrollListener() async {
    if (isLoadingMoreFinal) return;
    if (finalScrollController.position.pixels == finalScrollController.position.maxScrollExtent) {
      print("if scroll listener called");
      setState(() {
        isLoadingMoreFinal = true;
      });
      finalCount = finalCount + 1;
      finalEventList.addAll(await initialEventCubit.getFinalEventTest(page: finalCount));
      // getFinalEventData();
      // initialEventCubit.getFinalEvent(page: finalCount);
    }
    setState(() {
      isLoadingMoreFinal = false;
    });
  }

  String? roleName;
  String? eventImagePath;
  List<InitialEvent> finalEventList = [];
  List<InitialEvent> initialEventList = [];

  getInitialEventData() async {
    setState(() {
      isLoadingMore = true;
    });
    initialEventList = await initialEventCubit.getInitialEventTest(page: count);
    print("initialEventList ${initialEventList.length}");
    setState(() {
      isLoadingMore = false;
    });
    print("initialEventList length  ${initialEventList.length}");
    print("isLoadingMore  $isLoadingMore");
  }

  getFinalEventData() async {
    setState(() {
      isLoadingMoreFinal = true;
    });
    finalEventList = await initialEventCubit.getFinalEventTest(page: finalCount);
    print("finalEventList ${finalEventList.length}");
    setState(() {
      isLoadingMoreFinal = false;
    });
  }

  Future getUserDetailsFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    eventImagePath = prefs.getString("event_image_path") ?? "";
    roleName = prefs.getString(
          "role_name",
        ) ??
        "";

    print("role name $roleName");
    // roleName="asdasd";
    setState(() {});

    if (roleName == "Usher") {
      getInitialEventData();
      //  initialEventCubit.getInitialEvent(page: count);
    } else {
      tabList.forEach((element) {
        element.isSelected = false;
      });
      tabList[1].isSelected = true;
      getFinalEventData();
      //   initialEventCubit.getFinalEvent(page: finalCount);
    }
  }

  @override
  void initState() {
    getUserDetailsFromLocal();
    initialScrollController.addListener(_initialScrollListener);
    finalScrollController.addListener(_finalScrollListener);
    //_initialScrollListener();
    initialEventCubit = BlocProvider.of<InitialEventCubit>(context);

    // initialEventCubit.getFinalEvent(page: finalCount);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    //  initialEventCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Events".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          (roleName == "Usher")
              ? Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.02),
                      bottom: SizeConfig.height(context, 0.02),
                      left: SizeConfig.width(context, 0.05),
                      right: SizeConfig.width(context, 0.05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(2, (index) {
                      return GestureDetector(
                        onTap: () {
                          tabList.forEach((element) {
                            element?.isSelected = false;
                          });

                          setState(() {
                            count = 1;
                            finalCount = 1;
                            tabList[index].isSelected = true;
                            initialEventList.clear();
                            finalEventList.clear();
                          });
                          if (index == 0) {
                            getInitialEventData();
                            // initialEventCubit.getInitialEvent(page: count);
                          }
                          if (index == 1) {
                            getFinalEventData();
                            //   initialEventCubit.getFinalEvent(page: finalCount);
                          }
                        },
                        child: Container(
                          height: SizeConfig.height(context, 0.05),
                          width: SizeConfig.width(context, 0.44),
                          decoration: BoxDecoration(
                            color: tabList[index].isSelected ?? false
                                ? GlobalColors.submitButtonColor
                                : GlobalColors.whiteColor,
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            tabList[index].title ?? "",
                            style: TextStyle(
                                color: tabList[index].isSelected ?? false
                                    ? GlobalColors.whiteColor
                                    : GlobalColors.submitButtonColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.width(context, 0.03)),
                          )),
                        ),
                      );
                    }),
                  ),
                )
              : Container(),
          if (tabList.first.isSelected ?? false)
            (isLoadingMore)
                ? const LoadingWidget()
                : (initialEventList.isEmpty)
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
                          controller: initialScrollController,
                          itemBuilder: (context, index) {
                            var item = initialEventList.elementAt(index);

                            if (index < initialEventList.length) {
                              return EventsTab(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.eventDetailScreenRoute,
                                      arguments: EventDetailScreenArgs(eventId: item?.id ?? 0));
                                },
                                title: "${item?.eventName}",
                                subtitle:
                                    "${removeHtmlTags(item?.projectSummary ?? "")} \n ${item?.startDate} to ${item?.endDate}",
                                imagePath: "$eventImagePath${item?.logo}",
                              );
                            } else {
                              return LoadingWidget();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                          itemCount: (isLoadingMore) ? initialEventList.length ?? 0 + 1 : initialEventList.length ?? 0,
                        ),
                      ),
          if (tabList.last.isSelected ?? false)
            (isLoadingMoreFinal)
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
                          controller: finalScrollController,
                          itemBuilder: (context, index) {
                            var item = finalEventList.elementAt(index);

                            if (index < finalEventList.length) {
                              return EventsTab(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.eventDetailScreenRoute,
                                      arguments: EventDetailScreenArgs(finalInvitation: true, eventId: item?.id ?? 0));
                                },
                                title: "${item?.eventName}",
                                subtitle:
                                    "${removeHtmlTags(item?.projectSummary ?? "")} \n ${item?.startDate} to ${item?.endDate}",
                                imagePath: "$eventImagePath${item?.logo}",
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.height(context, 0.2),
                                  ),
                                  LoadingWidget(),
                                ],
                              );
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                          itemCount: (isLoadingMoreFinal) ? finalEventList.length ?? 0 + 1 : finalEventList.length ?? 0,
                        ),
                      )
        ],
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

class EventsTab extends StatelessWidget {
  const EventsTab({
    super.key,
    this.imagePath,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final String? imagePath;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //   height: SizeConfig.height(context, 0.135),
        width: SizeConfig.width(context, 0.9),
        margin: EdgeInsets.only(
          top: SizeConfig.height(context, 0.02),
          left: SizeConfig.width(context, 0.05),
          right: SizeConfig.width(context, 0.05),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: GlobalColors.textFieldHintColor),
          color: GlobalColors.backgroundColor,
          borderRadius: BorderRadius.circular(
            SizeConfig.width(context, 0.02),
          ),
        ),
        padding: EdgeInsets.only(
          top: SizeConfig.height(context, 0.01),
          bottom: SizeConfig.height(context, 0.01),
          //   bottom: SizeConfig.height(context, 0.01),
          left: SizeConfig.width(context, 0.02),
          right: SizeConfig.width(context, 0.02),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imagePath ?? ""),
              radius: SizeConfig.width(context, 0.09),
            ),
            SizedBox(
              width: SizeConfig.width(context, 0.03),
            ),
            Container(
              //   height: SizeConfig.height(context, 0.1),
              // color: Colors.red,
              width: SizeConfig.width(context, 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.width(context, 0.035),
                    ),
                  ),
                  Text(
                    subtitle ?? "",
                    maxLines: 3,
                    style: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.width(context, 0.030),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
