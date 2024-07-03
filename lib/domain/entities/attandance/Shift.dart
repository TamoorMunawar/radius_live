/// id : 2
/// company_id : "1"
/// shift_name : "General Shift"
/// shift_short_code : "GS"
/// color : "#99C7F1"
/// office_start_time : "09:00:00"
/// office_end_time : "18:00:00"
/// halfday_mark_time : null
/// late_mark_duration : "20"
/// clockin_in_day : "2"
/// office_open_days : "[\"1\",\"2\",\"3\",\"4\",\"5\"]"
/// early_clock_in : null

class Shift {
  Shift({
      this.id, 
      this.companyId, 
      this.shiftName, 
      this.shiftShortCode, 
      this.color, 
      this.officeStartTime, 
      this.officeEndTime, 
      this.halfdayMarkTime, 
      this.lateMarkDuration, 
      this.clockinInDay, 
      this.officeOpenDays, 
      this.earlyClockIn,});

  Shift.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    shiftName = json['shift_name'];
    shiftShortCode = json['shift_short_code'];
    color = json['color'];
    officeStartTime = json['office_start_time'];
    officeEndTime = json['office_end_time'];
    halfdayMarkTime = json['halfday_mark_time'];
    lateMarkDuration = json['late_mark_duration'];
    clockinInDay = json['clockin_in_day'];
    officeOpenDays = json['office_open_days'];
    earlyClockIn = json['early_clock_in'];
  }
  int? id;
  String? companyId;
  String? shiftName;
  String? shiftShortCode;
  String? color;
  String? officeStartTime;
  String? officeEndTime;
  dynamic halfdayMarkTime;
  String? lateMarkDuration;
  String? clockinInDay;
  String? officeOpenDays;
  dynamic earlyClockIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['shift_name'] = shiftName;
    map['shift_short_code'] = shiftShortCode;
    map['color'] = color;
    map['office_start_time'] = officeStartTime;
    map['office_end_time'] = officeEndTime;
    map['halfday_mark_time'] = halfdayMarkTime;
    map['late_mark_duration'] = lateMarkDuration;
    map['clockin_in_day'] = clockinInDay;
    map['office_open_days'] = officeOpenDays;
    map['early_clock_in'] = earlyClockIn;
    return map;
  }

}