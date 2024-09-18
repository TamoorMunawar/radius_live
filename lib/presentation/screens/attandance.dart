import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/network_utils.dart';
import '../../constants/size_config.dart';
import '../../domain/entities/attandance/Accept_event.dart';
import '../../domain/repository/logistics_repo.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late Future<List<Data>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = fetchEvents();
  }

  Future<List<Data>> fetchEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${NetworkUtils.baseUrl}/get-accepted-event'),
      headers: authorizationHeaders(prefs),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['detail']['data'];
      return data.map((item) => Data.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> updateStatus(int id, int approveStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${NetworkUtils.baseUrl}/approve-disapprove/$id'),
      headers: authorizationHeaders(prefs),
      body: jsonEncode({'approve_status': approveStatus}),
    );
    if (response.statusCode == 200) {


      setState(() {
        // Refresh the events list after updating status

        _eventsFuture = fetchEvents();
      });
    } else {
      throw Exception('Failed to update status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Data>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return _buildEventItem(event);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildEventItem(Data event) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.black12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      event.user?.imageUrl ?? "assets/icons/Event.png"),
                  radius: 30,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventModel?.eventName ?? "Event Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${event.user?.name ?? "Usher name"}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "${event.eventZone?.jobName ?? "Job Name"}, ${event.eventZone?.zoneName ?? "Zone"}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status: ${_getStatusText(event.approveStatus)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.width(context, 0.035),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleStatusChange(event.id, 0), // Decline
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Text(
                        "Decline",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: SizeConfig.width(context, 0.02)),
                    ElevatedButton(
                      onPressed: () => _handleStatusChange(event.id, 1), // Approve
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 12),
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

  Future<void> _handleStatusChange(int id, int approveStatus) async {
    try {
      await updateStatus(id, approveStatus);
    } catch (e) {
      // Handle the error if needed
      print("Error updating status: $e");
    }
  }

  String _getStatusText(bool? approveStatus) {
    if (approveStatus == false) {
      return "Declined";
    } else if (approveStatus == true) {
      return "Approved";
    } else {
      return "Pending";
    }
  }
}
