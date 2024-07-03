import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/presentation/cubits/announcement/announcement_cubit.dart';

import 'package:radar/presentation/widgets/LoadingWidget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key,  this.hideBackButton=false});
final bool hideBackButton;
  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late AnnouncementCubit announcementCubit;
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int count = 1;
  String removeHtmlTags(String htmlString) {
    final RegExp regExp =
    RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);

    return htmlString.replaceAll(regExp, '');
  }
  Future _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("if scroll listener called");
      setState(() {
        isLoadingMore = true;
      });
      count = count + 1;

      announcementCubit.getAnnouncement(page: count);
    }
    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    announcementCubit = BlocProvider.of<AnnouncementCubit>(context);
    announcementCubit.getAnnouncement(page: count);
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        //GlobalColors.backgroundColor,
        centerTitle: true,

        leading: (widget.hideBackButton)?Container():IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: EdgeInsets.only(left: SizeConfig.width(context, 0.05),right:  SizeConfig.width(context, 0.05)),
            child: Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.width(context, 0.05),
            ),
          ),
          color: Colors.white,
        ),
        title: Text(
          "Announcement".tr(),
          style: TextStyle(
            color: GlobalColors.whiteColor,
            fontSize: SizeConfig.width(context, 0.05),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
        print("announcement state $state ");
        if (state is AnnouncementSuccess) {
          return (state.announcement?.isEmpty??false)?Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height(context, 0.2)),
              child: Text(
                "No Data Found".tr(),
                style: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                    fontSize: SizeConfig.width(context, 0.06)),
              ),
            ),
          ):ListView.separated(
            padding: EdgeInsets.zero,
            controller: scrollController,
            itemBuilder: (context, index) {
              print("sssssssssssss ");
              var item = state.announcement?.elementAt(index);

              if (index < state.announcement!.length) {
                print("sssssssssssss ${state.announcement?.isEmpty}");
                return (Container(
              //    height: SizeConfig.height(context, 0.13),
                  width: SizeConfig.width(context, 0.9),
                  margin: EdgeInsets.only(
                      top: SizeConfig.height(context, 0.02),
                      left: SizeConfig.width(context, 0.05),
                      right: SizeConfig.width(context, 0.05)),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: GlobalColors.textFieldHintColor),
                      color: GlobalColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      )),
                  padding: EdgeInsets.only(
                    top: SizeConfig.height(context, 0.01),
                    //   bottom: SizeConfig.height(context, 0.01),
                    left: SizeConfig.width(context, 0.04),
                    right: SizeConfig.width(context, 0.04),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.width(context, 0.01)),
                        child: Text(
                          item?.noticeDate ?? "",
                          style:
                              TextStyle(color: GlobalColors.textFieldHintColor),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        title: Text(
                          item?.heading ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.width(context, 0.04),
                          ),
                        ),
                        subtitle: Text(
                          removeHtmlTags(item?.description ?? "")
                          ,
                          style: TextStyle(
                            color: GlobalColors.textFieldHintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.width(context, 0.035),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              } else {
                return const LoadingWidget();
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox();
            },
            itemCount: (isLoadingMore)
                ? state.announcement?.length ?? 0 + 1
                : state.announcement?.length ?? 0,
          );
        }
        if (state is AnnouncementLoading) {
          return Center(child: LoadingWidget());
        }
        return Container();
      }, listener: (context, state) {
        if (state is AnnouncementFailure) {
          AppUtils.showFlushBar(state.errorMessage, context);
        }
        if (state is AnnouncementSuccess) {
          /*if (state.announcement?.isEmpty ?? false) {
            AppUtils.showFlushBar("No Record Found", context);
          }*/
        }
      }),
    );
  }
}
