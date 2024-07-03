import 'Shift.dart';

/// clock_in_time : "2023-12-24T14:44:51+00:00"
/// clock_out_time : null
/// late : "yes"
/// half_day : "no"
/// shift_start_time : "2023-12-24T09:00:00+00:00"
/// shift_end_time : "2023-12-24T18:00:00+00:00"
/// work_from_type : "office"
/// overwrite_attendance : "no"
/// created_at : "2023-12-24T19:44:51+00:00"
/// employee_shift_id : "2"
/// formatted_clock_in_time : "02:44 PM"
/// formatted_date : "24 Dec, 23"
/// clock_in_date : "2023-12-24"
/// company : null
/// shift : {"id":2,"company_id":"1","shift_name":"General Shift","shift_short_code":"GS","color":"#99C7F1","office_start_time":"09:00:00","office_end_time":"18:00:00","halfday_mark_time":null,"late_mark_duration":"20","clockin_in_day":"2","office_open_days":"[\"1\",\"2\",\"3\",\"4\",\"5\"]","early_clock_in":null}

class Attandance {
  Attandance({
      this.clockInTime, 
      this.clockOutTime, 
      this.late, 
      this.halfDay, 
      this.shiftStartTime, 
      this.shiftEndTime, 
      this.workFromType, 
      this.overwriteAttendance, 
      this.createdAt, 
      this.employeeShiftId, 
      this.formattedClockInTime, 
      this.formattedDate, 
      this.formattedHour,
      this.formattedClockOutTime,
      this.clockInDate,
      this.company, 
      this.shift,});

  Attandance.fromJson(dynamic json) {
    clockInTime = json['clock_in_time'];
    clockOutTime = json['clock_out_time'];
    late = json['late'];
    halfDay = json['half_day'];
    formattedHour = json['formatted_hours'].toString()??"";
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    workFromType = json['work_from_type'];
    overwriteAttendance = json['overwrite_attendance'];
    createdAt = json['created_at'];
    //employeeShiftId = json['employee_shift_id'];
    formattedClockInTime = json['formatted_clock_in_time'];
    formattedClockOutTime = json['formatted_clock_out_time'];
    formattedDate = json['formatted_date'];
    clockInDate = json['clock_in_date'];
    company = json['company'];
   // shift = json['shift'] != null ? Shift.fromJson(json['shift']) : null;
  }
  String? clockInTime;
  dynamic clockOutTime;
  String? late;
  String? halfDay;
  String? shiftStartTime;
  String? shiftEndTime;
  String? workFromType;
  String? overwriteAttendance;
  String? createdAt;
  String? employeeShiftId;
  String? formattedClockInTime;
  String? formattedClockOutTime;
  String? formattedDate;
  String? formattedHour;
  String? clockInDate;
  dynamic company;
  Shift? shift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clock_in_time'] = clockInTime;
    map['clock_out_time'] = clockOutTime;
    map['late'] = late;
    map['half_day'] = halfDay;
    map['shift_start_time'] = shiftStartTime;
    map['shift_end_time'] = shiftEndTime;
    map['work_from_type'] = workFromType;
    map['overwrite_attendance'] = overwriteAttendance;
    map['created_at'] = createdAt;
    map['employee_shift_id'] = employeeShiftId;
    map['formatted_clock_in_time'] = formattedClockInTime;
    map['formatted_date'] = formattedDate;
    map['clock_in_date'] = clockInDate;
    map['company'] = company;
    if (shift != null) {
      map['shift'] = shift?.toJson();
    }
    return map;
  }

}