import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/network_utils.dart';
import '../../domain/entities/attandance/Accept_event.dart';
import '../../domain/repository/logistics_repo.dart';

class AttandaceScreen extends StatefulWidget {
  const AttandaceScreen({super.key});

  @override
  State<AttandaceScreen> createState() => _AttandaceScreenState();
}

class _AttandaceScreenState extends State<AttandaceScreen> {
  bool isLoading = true;
  List<Data> accpetlist = [];
  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${NetworkUtils.baseUrl}/get-accepted-event'),
      headers: authorizationHeaders(prefs),
    );
    print("https://radiusapp.online/api/v1/get-accepted-event");
    print(authorizationHeaders(prefs));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['detail']['data'];
      print("accept event");
      setState(() {
        accpetlist = data.map((item) => Data.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      // Handle the error
      setState(() {
        isLoading = false;
      });
    }
  }

  int _updatingItemId = -1;
  Future<void> updateStatus(var id, var approveStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      _updatingItemId = id;
    });

    try {
      final response = await http.post(
        Uri.parse('${NetworkUtils.baseUrl}/approve-disapprove/$id'),
        headers: authorizationHeaders(prefs),
        body: jsonEncode({'approve_status': approveStatus}),
      );

      if (response.statusCode == 200) {
        // Assuming the response is OK and status is updated successfully
        // Update the status in your list
        setState(() {
          // Update the status for the item with id
          final index = accpetlist.indexWhere((item) => item.id == id);
          if (index != -1) {
            accpetlist[index].approveStatus = approveStatus == 1;
          }
        });
      } else {
        // Handle error
        throw Exception('Failed to update status');
      }
    } catch (e) {
      // Handle exception
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
        _updatingItemId = -1;
      });
    }
  }

  String status = "Pending"; // Initial status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(accpetlist.length, (index) {
                  String _getStatusText(bool? approveStatus) {
                    if (approveStatus == null) {
                      return "Pending";
                    } else if (approveStatus) {
                      return "Approved";
                    } else {
                      return "Declined";
                    }
                  }

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: SizeConfig.width(context, 0.9),
                      margin: EdgeInsets.only(
                          top: SizeConfig.height(context, 0.02),
                          left: SizeConfig.width(context, 0.05),
                          right: SizeConfig.width(context, 0.05)),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: GlobalColors.textFieldHintColor),
                          color: GlobalColors.backgroundColor,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.width(context, 0.02),
                          )),
                      padding: EdgeInsets.only(
                        top: SizeConfig.height(context, 0.01),
                        bottom: SizeConfig.height(context, 0.01),
                        left: SizeConfig.width(context, 0.02),
                        right: SizeConfig.width(context, 0.02),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    accpetlist[index].user?.imageUrl ??
                                        "assets/icons/Event.png"),
                                radius: SizeConfig.width(context, 0.09),
                              ),
                              SizedBox(
                                width: SizeConfig.width(context, 0.03),
                              ),
                              Container(
                                width: SizeConfig.width(context, 0.6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      accpetlist[index].eventModel?.eventName ??
                                          "Event Name",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.width(context, 0.035),
                                      ),
                                    ),
                                    Text(
                                      "${accpetlist[index].user?.name ?? "Usher name"},${accpetlist[index].user?.email ?? "Email"}",
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: GlobalColors.textFieldHintColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            SizeConfig.width(context, 0.030),
                                      ),
                                    ),
                                    Text(
                                      "${accpetlist[index].eventZone?.jobName ?? "Job name"},  ${accpetlist[index].eventZone?.zoneName ?? "Zone"}",
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: GlobalColors.textFieldHintColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                        SizeConfig.width(context, 0.030),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status: ${_getStatusText(accpetlist[index].approveStatus)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.width(context, 0.035),
                                ),
                              ),
                              Row(children: [
                                if (isLoading &&
                                    _updatingItemId == accpetlist[index].id)
                                  CircularProgressIndicator()
                                else ...[
                                  ElevatedButton(
                                    onPressed: () => updateStatus(
                                        accpetlist[index].id, 0), // Decline
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                      width: SizeConfig.width(context, 0.02)),
                                  ElevatedButton(
                                    onPressed: () => updateStatus(
                                        accpetlist[index].id, 1), // Approve
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                    child: Text(
                                      "Approve",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ]),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
    );
  }
}

class EventsDetailTab extends StatefulWidget {
  const EventsDetailTab({
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
  _EventsDetailTabState createState() => _EventsDetailTabState();
}

class _EventsDetailTabState extends State<EventsDetailTab> {
  String status = "Pending"; // Initial status

  void updateStatus(String newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: SizeConfig.width(context, 0.9),
        margin: EdgeInsets.only(
            top: SizeConfig.height(context, 0.02),
            left: SizeConfig.width(context, 0.05),
            right: SizeConfig.width(context, 0.05)),
        decoration: BoxDecoration(
            border: Border.all(color: GlobalColors.textFieldHintColor),
            color: GlobalColors.backgroundColor,
            borderRadius: BorderRadius.circular(
              SizeConfig.width(context, 0.02),
            )),
        padding: EdgeInsets.only(
          top: SizeConfig.height(context, 0.01),
          bottom: SizeConfig.height(context, 0.01),
          left: SizeConfig.width(context, 0.02),
          right: SizeConfig.width(context, 0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imagePath ?? ""),
                  radius: SizeConfig.width(context, 0.09),
                ),
                SizedBox(
                  width: SizeConfig.width(context, 0.03),
                ),
                Container(
                  width: SizeConfig.width(context, 0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.width(context, 0.035),
                        ),
                      ),
                      Text(
                        widget.subtitle ?? "",
                        maxLines: 3,
                        style: TextStyle(
                          color: GlobalColors.textFieldHintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.width(context, 0.030),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height(context, 0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status: $status",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.width(context, 0.035),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => updateStatus("Decline"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        "Decline",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: SizeConfig.width(context, 0.02)),
                    ElevatedButton(
                      onPressed: () => updateStatus("Approve"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        "Approve",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
