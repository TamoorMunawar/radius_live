import 'dart:convert';

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../../constants/network_utils.dart';
import '../../../domain/repository/logistics_repo.dart';
class EventHistory extends StatefulWidget {
  const EventHistory({Key? key}) : super(key: key);

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> {
  List<Data> assetlist = [];
  List<TextEditingController> controllers = [];
  bool isLoading = true;
  bool isLoading1 = true;
  @override
  void initState() {
    super.initState();
    fetcheventHistory();
  }

  Future<void> fetcheventHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${NetworkUtils.baseUrl}/user/event-history'),
      headers: authorizationHeaders(prefs),
    );
    print("https://radiusapp.online/api/v1/user/event-history");
    print(authorizationHeaders(prefs));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      final List<dynamic> data = jsonResponse['data'];
      print("accept event");
      assetlist = data.map((item) => Data.fromJson(item)).toList();

    } else {
      // Handle the error
      setState(() {
        isLoading = false;
      });
    }
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
          "Event History".tr(),
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
                      'Event List'.tr(),
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
                      'Event JOB'.tr(),
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
                      'Rating'.tr(),
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
            child: ListView.builder(
              itemCount: assetlist.length,
              itemBuilder: (context, index) {
                final asset = assetlist[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            asset.eventZone?.zoneName ?? "",
                            style: TextStyle(
                              color: GlobalColors.goodMorningColor,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.width(context, 0.040),
                            ),
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "${asset.eventZone?.jobName ?? ""}",
                            style: TextStyle(
                              color: GlobalColors.goodMorningColor,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.width(context, 0.040),
                            ),
                          ),
                        ),
                      ),
                      // This will show 3 full stars and one half-star
                      Flexible(
                        flex: 1,
                        child: Center(
                          child:  StarRating(rating: 3.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class StarRating extends StatelessWidget {
  final double rating; // Pass the rating value (e.g., 3.5, 4.0)

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          if (index < rating.floor()) {
            // Full star for integer part of the rating
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          } else if (index < rating) {
            // Half star for decimal part of the rating
            return Icon(
              Icons.star_half,
              color: Colors.yellow,
            );
          } else {
            // Empty star for remaining part
            return Icon(
              Icons.star_border,
              color: Colors.grey,
            );
          }
        }),
      ),
    );
  }
}


class EventHistoryModel {
  bool? success;
  List<Data>? data;

  EventHistoryModel({this.success, this.data});

  EventHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? eventModelId;
  int? eventZoneJobId;
  int? userId;
  String? invitationCount;
  String? rejectionCount;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? approveStatus;
  Null? isUserOut;
  Null? eventReviews;
  Null? eventModel;
  EventZone? eventZone;

  Data(
      {this.id,
        this.eventModelId,
        this.eventZoneJobId,
        this.userId,
        this.invitationCount,
        this.rejectionCount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.approveStatus,
        this.isUserOut,
        this.eventReviews,
        this.eventModel,
        this.eventZone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    eventZoneJobId = json['event_zone_job_id'];
    userId = json['user_id'];
    invitationCount = json['invitation_count'];
    rejectionCount = json['rejection_count'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approveStatus = json['approve_status'];
    isUserOut = json['is_user_out'];
    eventReviews = json['event_reviews'];
    eventModel = json['event_model'];
    eventZone = json['event_zone'] != null
        ? new EventZone.fromJson(json['event_zone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_model_id'] = this.eventModelId;
    data['event_zone_job_id'] = this.eventZoneJobId;
    data['user_id'] = this.userId;
    data['invitation_count'] = this.invitationCount;
    data['rejection_count'] = this.rejectionCount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['approve_status'] = this.approveStatus;
    data['is_user_out'] = this.isUserOut;
    data['event_reviews'] = this.eventReviews;
    data['event_model'] = this.eventModel;
    if (this.eventZone != null) {
      data['event_zone'] = this.eventZone!.toJson();
    }
    return data;
  }
}

class EventZone {
  int? id;
  int? eventModelId;
  int? zoneId;
  int? eventJobId;
  int? maleMainSeats;
  int? femaleMainSeats;
  Null? anyGenderMainSeats;
  Null? maleStbySeats;
  Null? femaleStbySeats;
  Null? anyGenderStbySeats;
  String? createdAt;
  String? updatedAt;
  int? newZoneId;
  String? zoneName;
  String? jobName;

  EventZone(
      {this.id,
        this.eventModelId,
        this.zoneId,
        this.eventJobId,
        this.maleMainSeats,
        this.femaleMainSeats,
        this.anyGenderMainSeats,
        this.maleStbySeats,
        this.femaleStbySeats,
        this.anyGenderStbySeats,
        this.createdAt,
        this.updatedAt,
        this.newZoneId,
        this.zoneName,
        this.jobName});

  EventZone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    zoneId = json['zone_id'];
    eventJobId = json['event_job_id'];
    maleMainSeats = json['male_main_seats'];
    femaleMainSeats = json['female_main_seats'];
    anyGenderMainSeats = json['any_gender_main_seats'];
    maleStbySeats = json['male_stby_seats'];
    femaleStbySeats = json['female_stby_seats'];
    anyGenderStbySeats = json['any_gender_stby_seats'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    newZoneId = json['new_zone_id'];
    zoneName = json['zone_name'];
    jobName = json['job_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_model_id'] = this.eventModelId;
    data['zone_id'] = this.zoneId;
    data['event_job_id'] = this.eventJobId;
    data['male_main_seats'] = this.maleMainSeats;
    data['female_main_seats'] = this.femaleMainSeats;
    data['any_gender_main_seats'] = this.anyGenderMainSeats;
    data['male_stby_seats'] = this.maleStbySeats;
    data['female_stby_seats'] = this.femaleStbySeats;
    data['any_gender_stby_seats'] = this.anyGenderStbySeats;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['new_zone_id'] = this.newZoneId;
    data['zone_name'] = this.zoneName;
    data['job_name'] = this.jobName;
    return data;
  }
}
