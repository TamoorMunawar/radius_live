import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:radar/presentation/screens/job_dashboard_screen.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:screenshot/screenshot.dart';

class ZoneDashBoardScreen extends StatefulWidget {
  const ZoneDashBoardScreen({Key? key, required this.eventId}) : super(key: key);
  final int eventId;

  @override
  State<ZoneDashBoardScreen> createState() => _ZoneDashBoardScreenState();
}

class _ZoneDashBoardScreenState extends State<ZoneDashBoardScreen> {
  late DashboardCubit dashboardCubit;

  @override
  void initState() {
    dashboardCubit = BlocProvider.of<DashboardCubit>(context);
    dashboardCubit.dashboardZone(eventId: widget.eventId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
          "Zones".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.height(context, 0.02),
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05)),
            height: SizeConfig.height(context, 0.07),
            color: GlobalColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Zones'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Actual'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Planned'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Rate'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: SizeConfig.width(
                            context,
                            0.035,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildDividerWidget(context: context),
          Expanded(
            child: BlocConsumer<DashboardCubit, DashboardState>(builder: (context, state) {
              if (state is DashboardDetailLoading) {
                return Flexible(flex: 8, child: const LoadingWidget());
              }
              if (state is DashboardZoneSuccess) {
                return Flexible(
                  flex: 8,
                  // flex: 12,
                  fit: FlexFit.tight,
                  child: ListView.separated(
                      itemCount: state.dashboardDetail.length,
                      separatorBuilder: (context, index) {
                        return buildDividerWidget(context: context);
                      },
                      itemBuilder: (context, index) {
                        var item = state.dashboardDetail.elementAt(index);
                        return Container(
                          //    height: SizeConfig.height(context, 0.13),
                          width: SizeConfig.width(context, 0.9),
                          margin: EdgeInsets.only(
                              left: SizeConfig.width(context, 0.05), right: SizeConfig.width(context, 0.05)),
                          decoration: BoxDecoration(
                              color: GlobalColors.backgroundColor,
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              )),
                          padding: EdgeInsets.only(
                            top: SizeConfig.height(context, 0.01),
                            bottom: SizeConfig.height(context, 0.01),
                            // left: SizeConfig.width(context, 0.04),
                            // right: SizeConfig.width(context, 0.04),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*  Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.width(context, 0.05)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Supervisor".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: GlobalColors.submitButtonColor,
                                          fontSize:
                                          SizeConfig.width(context, 0.035)),
                                    ),
                                    Text(
                                      "${state.dashboardDetail[index].suppervisor}"
                                          .tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: GlobalColors.submitButtonColor,
                                          fontSize:
                                          SizeConfig.width(context, 0.035)),
                                    ),
                                  ],
                                ),
                              ),*/
                              SizedBox(
                                height: SizeConfig.height(context, 0.01),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Supervisor".tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: GlobalColors.submitButtonColor,
                                              fontSize: SizeConfig.width(context, 0.035)),
                                        ),
                                        Text(
                                          item.categoryName ?? "",
                                          // displayDonationDate(
                                          //   donationHistoryItem.donationDate ?? '',
                                          // ),
                                          style: TextStyle(
                                              color: GlobalColors.whiteColor,
                                              fontSize: SizeConfig.width(context, 0.035)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*  Flexible(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        item.categoryName ?? "",
                                        // displayDonationDate(
                                        //   donationHistoryItem.donationDate ?? '',
                                        // ),
                                        style: TextStyle(

                                            color: GlobalColors.whiteColor,
                                            fontSize:
                                            SizeConfig.width(context, 0.035)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),*/
                                  Flexible(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        item.actualSeats.toString() ?? "",
                                        // displayDonationDate(
                                        //   donationHistoryItem.donationDate ?? '',
                                        // ),
                                        style: TextStyle(
                                            color: GlobalColors.whiteColor, fontSize: SizeConfig.width(context, 0.035)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        item.plannedSeats.toString() ?? "",
                                        // displayDonationDate(
                                        //   donationHistoryItem.donationDate ?? '',
                                        // ),
                                        style: TextStyle(
                                            color: GlobalColors.whiteColor, fontSize: SizeConfig.width(context, 0.035)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${state.dashboardDetail[index].suppervisor}".tr(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: GlobalColors.submitButtonColor,
                                            fontSize: SizeConfig.width(context, 0.035),
                                          ),
                                        ),
                                        Text(
                                          item.rate ?? "",
                                          // displayDonationDate(
                                          //   donationHistoryItem.donationDate ?? '',
                                          // ),
                                          style: TextStyle(
                                              color: GlobalColors.whiteColor,
                                              fontSize: SizeConfig.width(context, 0.035)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is DashboardZoneSuccess) {}
              if (state is DashboardDetailFailed) {
                AppUtils.showFlushBar(state.errorMessage, context);
              }
            }),
          ),
        ],
      ),
    );
  }
}
