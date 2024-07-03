/// y : 0
/// m : 0
/// d : 0
/// h : 8
/// i : 0
/// s : 0
/// f : 0
/// weekday : 0
/// weekday_behavior : 0
/// first_last_day_of : 0
/// invert : 0
/// days : 0
/// special_type : 0
/// special_amount : 0
/// have_weekday_relative : 0
/// have_special_relative : 0

class TotalHours {
  TotalHours({
      this.y, 
      this.m, 
      this.d, 
      this.h, 
      this.i, 
      this.s, 
      this.f, 
      this.weekday, 
      this.weekdayBehavior, 
      this.firstLastDayOf, 
      this.invert, 
      this.days, 
      this.specialType, 
      this.specialAmount, 
      this.haveWeekdayRelative, 
      this.haveSpecialRelative,});

  TotalHours.fromJson(dynamic json) {
    y = json['y'];
    m = json['m'];
    d = json['d'];
    h = json['h'];
    i = json['i'];
    s = json['s'];
    f = json['f'];
    weekday = json['weekday'];
    weekdayBehavior = json['weekday_behavior'];
    firstLastDayOf = json['first_last_day_of'];
    invert = json['invert'];
    days = json['days'];
    specialType = json['special_type'];
    specialAmount = json['special_amount'];
    haveWeekdayRelative = json['have_weekday_relative'];
    haveSpecialRelative = json['have_special_relative'];
  }
  var y;
  var m;
  var d;
  var h;
  var i;
  var s;
  var f;
  var weekday;
  var weekdayBehavior;
  var firstLastDayOf;
  var invert;
  var days;
  var specialType;
  var specialAmount;
  var haveWeekdayRelative;
  var haveSpecialRelative;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['y'] = y;
    map['m'] = m;
    map['d'] = d;
    map['h'] = h;
    map['i'] = i;
    map['s'] = s;
    map['f'] = f;
    map['weekday'] = weekday;
    map['weekday_behavior'] = weekdayBehavior;
    map['first_last_day_of'] = firstLastDayOf;
    map['invert'] = invert;
    map['days'] = days;
    map['special_type'] = specialType;
    map['special_amount'] = specialAmount;
    map['have_weekday_relative'] = haveWeekdayRelative;
    map['have_special_relative'] = haveSpecialRelative;
    return map;
  }

}