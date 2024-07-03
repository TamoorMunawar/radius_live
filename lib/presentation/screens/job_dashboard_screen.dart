import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/dashboard/dashboard_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:screenshot/screenshot.dart';

class JobDashBoardScreen extends StatefulWidget {
  const JobDashBoardScreen({Key? key, this.eventId}) : super(key: key);
  final int? eventId;

  @override
  State<JobDashBoardScreen> createState() => _JobDashBoardScreenState();
}

class _JobDashBoardScreenState extends State<JobDashBoardScreen> {
  late DashboardCubit dashboardCubit;

  @override
  void initState() {
    dashboardCubit = BlocProvider.of<DashboardCubit>(context);
    dashboardCubit.dashboardJob(eventId: widget.eventId);
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
        backgroundColor: GlobalColors.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.width(context, 0.05),
                right: SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Jobs".tr(),
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
                      'Jobs'.tr(),
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
            child: BlocConsumer<DashboardCubit, DashboardState>(
                builder: (context, state) {
              if (state is DashboardDetailLoading) {
                return Flexible(flex: 8, child: const LoadingWidget());
              }
              if (state is DashboardJobSuccess) {
                print(state.jobDashboard);
                return Flexible(
                  flex: 8,
                  // flex: 12,
                  fit: FlexFit.tight,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return           buildDividerWidget(context: context);
                      },
                      itemCount: state.jobDashboard.length,
                      itemBuilder: (context, index) {
                        var item = state.jobDashboard.elementAt(index);
                        return Container(
                          //    height: SizeConfig.height(context, 0.13),
                          width: SizeConfig.width(context, 0.9),
                          margin: EdgeInsets.only(
                              //  bottom: SizeConfig.height(context, 0.02),
                              left: SizeConfig.width(context, 0.05),
                              right: SizeConfig.width(context, 0.05)),
                          decoration: BoxDecoration(
                              color: GlobalColors.backgroundColor,
                              borderRadius: BorderRadius.circular(
                                SizeConfig.width(context, 0.02),
                              )),
                          padding: EdgeInsets.only(
                            top: SizeConfig.height(context, 0.01),
                            bottom: SizeConfig.height(context, 0.01),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    item.name ?? "",
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
                              ),
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    item.actualSeats.toString() ?? "",
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
                              ),
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    item.planned.toString() ?? "",
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
                              ),
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    item.rate.toString() ?? "",
                                    // displayDonationDate(
                                    //   donationHistoryItem.donationDate ?? '',
                                    // ),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: GlobalColors.submitButtonColor,
                                        fontSize:
                                            SizeConfig.width(context, 0.035)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is DashboardJobSuccess) {}
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

Widget buildDividerWidget({required BuildContext context,EdgeInsetsGeometry ?padding}) {
  return Padding(
    padding: padding??EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context, 0.05)),
    child: Divider(
      color: Colors.white.withOpacity(0.3),
    ),
  );
}
