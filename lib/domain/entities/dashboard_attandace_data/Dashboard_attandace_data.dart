import 'package:radar/domain/entities/dashboard_attandace_data/Total_hours.dart';

import 'TimeDiff.dart';

/// clock_in_time : "12:00 PM"
/// time_diff : {"y":0,"m":0,"d":0,"h":5,"i":0,"s":20,"f":0.54759400000000002517452912798034958541393280029296875,"weekday":0,"weekday_behavior":0,"first_last_day_of":0,"invert":0,"days":0,"special_type":0,"special_amount":0,"have_weekday_relative":0,"have_special_relative":0}
/// clock_out_time : null
/// event_start_time : "4:00 AM"
/// event_end_time : "12:00 PM"

class DashboardAttandanceData {
  DashboardAttandanceData({
      this.clockInTime, 
      this.totalHours,
      this.timeDiff,
      this.clockOutTime, 
      this.eventStartTime, 
      this.eventEndTime,});

  DashboardAttandanceData.fromJson(dynamic json) {
    clockInTime = json['clock_in_time'];
    timeDiff = json['time_diff'] != null ? TimeDiff.fromJson(json['time_diff']) : null;
    totalHours = json['total_hour'] != null ? TotalHours.fromJson(json['total_hour']) : null;
    clockOutTime = json['clock_out_time'];
    eventStartTime = json['event_start_time'];
    eventEndTime = json['event_end_time'];
  }
  String? clockInTime;
  TimeDiff? timeDiff;
  TotalHours? totalHours;
  dynamic clockOutTime;
  String? eventStartTime;
  String? eventEndTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clock_in_time'] = clockInTime;
    if (timeDiff != null) {
      map['time_diff'] = timeDiff?.toJson();
    }
    map['clock_out_time'] = clockOutTime;
    map['event_start_time'] = eventStartTime;
    map['event_end_time'] = eventEndTime;
    return map;
  }

}