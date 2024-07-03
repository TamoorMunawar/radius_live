/// unpaidInvoices : 0
/// totalProjects : 30
/// pendingTasks : 1
/// checkouts : "1"
/// avg_attendance : "0%"
/// avg_checkout : "0%"
/// planned_ushers : 6
/// invited_ushers : 0
/// confirmed_ushers : 6
/// total_salary : 1500
/// planned_budget : 1500
/// confirmed_budget : 0
/// attendance_data : [{"employeeCount":12,"clockOutCount":2,"hour":10,"upcoming_birthday":null,"designation":null,"company":null,"department":null}]
/// male_total_seats : 20
/// female_total_seats : 0
/// both_total_seats : 0
/// male_stby_total_seats : 0
/// female_stby_total_seats : 0
/// both_stby_total_seats : 0
/// male_confirmed : 0
/// female_confirmed : 0
/// both_confirmed : 0
/// total_seats : 10
/// filled_seats : 6
/// remaining_seats : 4

class DashboardDetail {
  DashboardDetail({
      num? unpaidInvoices, 
      int? eventId,
      int? usherCountOutside,
      int? totalZone,
      num? totalProjects,
      num? pendingTasks, 
      String? checkouts, 
      String? checkins,
      String? avgAttendance,
      String? avgCheckout, 
      num? plannedUshers, 
      num? invitedUshers, 
      num? confirmedUshers, 
      num? totalSalary, 
      num? plannedBudget, 
      num? confirmedBudget, 
      List<AttendanceData>? attendanceData, 
      num? maleTotalSeats, 
      num? femaleTotalSeats, 
      num? bothTotalSeats, 
      num? maleStbyTotalSeats, 
      num? femaleStbyTotalSeats, 
      num? bothStbyTotalSeats, 
      num? maleConfirmed, 
      num? femaleConfirmed, 
      num? bothConfirmed, 
      num? totalSeats, 
      num? filledSeats, 
      num? remainingSeats,}){
    _unpaidInvoices = unpaidInvoices;
    _totalProjects = totalProjects;
    _totalZone = totalZone;
    _pendingTasks = pendingTasks;
    _checkouts = checkouts;
    _checkins = checkins;
    _avgAttendance = avgAttendance;
    _avgCheckout = avgCheckout;
    _plannedUshers = plannedUshers;
    _invitedUshers = invitedUshers;
    _confirmedUshers = confirmedUshers;
    _totalSalary = totalSalary;
    _plannedBudget = plannedBudget;
    _confirmedBudget = confirmedBudget;
    _attendanceData = attendanceData;
    _maleTotalSeats = maleTotalSeats;
    _femaleTotalSeats = femaleTotalSeats;
    _bothTotalSeats = bothTotalSeats;
    _maleStbyTotalSeats = maleStbyTotalSeats;
    _femaleStbyTotalSeats = femaleStbyTotalSeats;
    _bothStbyTotalSeats = bothStbyTotalSeats;
    _maleConfirmed = maleConfirmed;
    _femaleConfirmed = femaleConfirmed;
    _bothConfirmed = bothConfirmed;
    _totalSeats = totalSeats;
    _filledSeats = filledSeats;
    _remainingSeats = remainingSeats;
}

  DashboardDetail.fromJson(dynamic json) {
    _unpaidInvoices = json['unpaidInvoices'];
    _eventId = json['event_id'];
    _usherCountOutside = json['outoff_event_ushers'];
    _totalZone = json['total_zones'];
    _totalProjects = json['totalProjects'];
    _pendingTasks = json['pendingTasks'];
    _checkouts = json['checkouts'];
    _checkins = json['checkins'];
    _avgAttendance = json['avg_attendance'];
    _avgCheckout = json['avg_checkout'];
    _plannedUshers = json['planned_ushers'];
    _invitedUshers = json['invited_ushers'];
    _confirmedUshers = json['confirmed_ushers'];
    _totalSalary = json['total_salary'];
    _plannedBudget = json['planned_budget'];
    _confirmedBudget = json['confirmed_budget'];
    if (json['attendance_data'] != null) {
      _attendanceData = [];
      json['attendance_data'].forEach((v) {
        _attendanceData?.add(AttendanceData.fromJson(v));
      });
    }
    _maleTotalSeats = json['male_total_seats'];
    _femaleTotalSeats = json['female_total_seats'];
    _bothTotalSeats = json['both_total_seats'];
    _maleStbyTotalSeats = json['male_stby_total_seats'];
    _femaleStbyTotalSeats = json['female_stby_total_seats'];
    _bothStbyTotalSeats = json['both_stby_total_seats'];
    _maleConfirmed = json['male_confirmed'];
    _femaleConfirmed = json['female_confirmed'];
    _bothConfirmed = json['both_confirmed'];
    _totalSeats = json['total_seats'];
    _filledSeats = json['filled_seats'];
    _remainingSeats = json['remaining_seats'];
  }
  num? _unpaidInvoices;
  int? _eventId;
  int? _usherCountOutside;
  int? _totalZone;
  num? _totalProjects;
  num? _pendingTasks;
  String? _checkouts;
  String? _checkins;
  String? _avgAttendance;
  String? _avgCheckout;
  num? _plannedUshers;
  num? _invitedUshers;
  num? _confirmedUshers;
  num? _totalSalary;
  num? _plannedBudget;
  num? _confirmedBudget;
  List<AttendanceData>? _attendanceData;
  num? _maleTotalSeats;
  num? _femaleTotalSeats;
  num? _bothTotalSeats;
  num? _maleStbyTotalSeats;
  num? _femaleStbyTotalSeats;
  num? _bothStbyTotalSeats;
  num? _maleConfirmed;
  num? _femaleConfirmed;
  num? _bothConfirmed;
  num? _totalSeats;
  num? _filledSeats;
  num? _remainingSeats;
DashboardDetail copyWith({  num? unpaidInvoices,
  num? totalProjects,
  int? eventId,

  int? usherCountOutside,
  int? totalZone,
  num? pendingTasks,
  String? checkouts,
  String? avgAttendance,
  String? avgCheckout,
  num? plannedUshers,
  num? invitedUshers,
  num? confirmedUshers,
  num? totalSalary,
  num? plannedBudget,
  num? confirmedBudget,
  List<AttendanceData>? attendanceData,
  num? maleTotalSeats,
  num? femaleTotalSeats,
  num? bothTotalSeats,
  num? maleStbyTotalSeats,
  num? femaleStbyTotalSeats,
  num? bothStbyTotalSeats,
  num? maleConfirmed,
  num? femaleConfirmed,
  num? bothConfirmed,
  num? totalSeats,
  num? filledSeats,
  num? remainingSeats,
}) => DashboardDetail(  unpaidInvoices: unpaidInvoices ?? _unpaidInvoices,
  totalProjects: totalProjects ?? _totalProjects,
  pendingTasks: pendingTasks ?? _pendingTasks,
  eventId: eventId ?? _eventId,
  usherCountOutside: usherCountOutside ?? _usherCountOutside,
  totalZone: totalZone ?? _totalZone,
  checkouts: checkouts ?? _checkouts,
  checkins: checkins ?? _checkins,
  avgAttendance: avgAttendance ?? _avgAttendance,
  avgCheckout: avgCheckout ?? _avgCheckout,
  plannedUshers: plannedUshers ?? _plannedUshers,
  invitedUshers: invitedUshers ?? _invitedUshers,
  confirmedUshers: confirmedUshers ?? _confirmedUshers,
  totalSalary: totalSalary ?? _totalSalary,
  plannedBudget: plannedBudget ?? _plannedBudget,
  confirmedBudget: confirmedBudget ?? _confirmedBudget,
  attendanceData: attendanceData ?? _attendanceData,
  maleTotalSeats: maleTotalSeats ?? _maleTotalSeats,
  femaleTotalSeats: femaleTotalSeats ?? _femaleTotalSeats,
  bothTotalSeats: bothTotalSeats ?? _bothTotalSeats,
  maleStbyTotalSeats: maleStbyTotalSeats ?? _maleStbyTotalSeats,
  femaleStbyTotalSeats: femaleStbyTotalSeats ?? _femaleStbyTotalSeats,
  bothStbyTotalSeats: bothStbyTotalSeats ?? _bothStbyTotalSeats,
  maleConfirmed: maleConfirmed ?? _maleConfirmed,
  femaleConfirmed: femaleConfirmed ?? _femaleConfirmed,
  bothConfirmed: bothConfirmed ?? _bothConfirmed,
  totalSeats: totalSeats ?? _totalSeats,
  filledSeats: filledSeats ?? _filledSeats,
  remainingSeats: remainingSeats ?? _remainingSeats,
);
  num? get unpaidInvoices => _unpaidInvoices;
  num? get eventId => _eventId;
  num? get usherCountOutside => _usherCountOutside;
  num? get totalZone => _totalZone;
  num? get totalProjects => _totalProjects;
  num? get pendingTasks => _pendingTasks;
  String? get checkouts => _checkouts;
  String? get checkins => _checkins;
  String? get avgAttendance => _avgAttendance;
  String? get avgCheckout => _avgCheckout;
  num? get plannedUshers => _plannedUshers;
  num? get invitedUshers => _invitedUshers;
  num? get confirmedUshers => _confirmedUshers;
  num? get totalSalary => _totalSalary;
  num? get plannedBudget => _plannedBudget;
  num? get confirmedBudget => _confirmedBudget;
  List<AttendanceData>? get attendanceData => _attendanceData;
  num? get maleTotalSeats => _maleTotalSeats;
  num? get femaleTotalSeats => _femaleTotalSeats;
  num? get bothTotalSeats => _bothTotalSeats;
  num? get maleStbyTotalSeats => _maleStbyTotalSeats;
  num? get femaleStbyTotalSeats => _femaleStbyTotalSeats;
  num? get bothStbyTotalSeats => _bothStbyTotalSeats;
  num? get maleConfirmed => _maleConfirmed;
  num? get femaleConfirmed => _femaleConfirmed;
  num? get bothConfirmed => _bothConfirmed;
  num? get totalSeats => _totalSeats;
  num? get filledSeats => _filledSeats;
  num? get remainingSeats => _remainingSeats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unpaidInvoices'] = _unpaidInvoices;
    map['event_id'] = _eventId;
    map['outoff_event_ushers'] = _usherCountOutside;
    map['totalProjects'] = _totalProjects;
    map['pendingTasks'] = _pendingTasks;
    map['checkouts'] = _checkouts;
    map['checkins'] = _checkins;
    map['avg_attendance'] = _avgAttendance;
    map['avg_checkout'] = _avgCheckout;
    map['planned_ushers'] = _plannedUshers;
    map['invited_ushers'] = _invitedUshers;
    map['confirmed_ushers'] = _confirmedUshers;
    map['total_salary'] = _totalSalary;
    map['planned_budget'] = _plannedBudget;
    map['confirmed_budget'] = _confirmedBudget;
    if (_attendanceData != null) {
      map['attendance_data'] = _attendanceData?.map((v) => v.toJson()).toList();
    }
    map['male_total_seats'] = _maleTotalSeats;
    map['female_total_seats'] = _femaleTotalSeats;
    map['both_total_seats'] = _bothTotalSeats;
    map['male_stby_total_seats'] = _maleStbyTotalSeats;
    map['female_stby_total_seats'] = _femaleStbyTotalSeats;
    map['both_stby_total_seats'] = _bothStbyTotalSeats;
    map['male_confirmed'] = _maleConfirmed;
    map['female_confirmed'] = _femaleConfirmed;
    map['both_confirmed'] = _bothConfirmed;
    map['total_seats'] = _totalSeats;
    map['filled_seats'] = _filledSeats;
    map['remaining_seats'] = _remainingSeats;
    return map;
  }

}

/// employeeCount : 12
/// clockOutCount : 2
/// hour : 10
/// upcoming_birthday : null
/// designation : null
/// company : null
/// department : null

class AttendanceData {
  AttendanceData({
      num? employeeCount, 
      num? clockOutCount, 
      num? hour, 
      dynamic upcomingBirthday, 
      dynamic designation, 
      dynamic company, 
      dynamic department,}){
    _employeeCount = employeeCount;
    _clockOutCount = clockOutCount;
    _hour = hour;
    _upcomingBirthday = upcomingBirthday;
    _designation = designation;
    _company = company;
    _department = department;
}

  AttendanceData.fromJson(dynamic json) {
    _employeeCount = json['employeeCount'];
    _clockOutCount = json['clockOutCount'];
    _hour = json['hour'];
    _upcomingBirthday = json['upcoming_birthday'];
    _designation = json['designation'];
    _company = json['company'];
    _department = json['department'];
  }
  num? _employeeCount;
  num? _clockOutCount;
  num? _hour;
  dynamic _upcomingBirthday;
  dynamic _designation;
  dynamic _company;
  dynamic _department;
AttendanceData copyWith({  num? employeeCount,
  num? clockOutCount,
  num? hour,
  dynamic upcomingBirthday,
  dynamic designation,
  dynamic company,
  dynamic department,
}) => AttendanceData(  employeeCount: employeeCount ?? _employeeCount,
  clockOutCount: clockOutCount ?? _clockOutCount,
  hour: hour ?? _hour,
  upcomingBirthday: upcomingBirthday ?? _upcomingBirthday,
  designation: designation ?? _designation,
  company: company ?? _company,
  department: department ?? _department,
);
  num? get employeeCount => _employeeCount;
  num? get clockOutCount => _clockOutCount;
  num? get hour => _hour;
  dynamic get upcomingBirthday => _upcomingBirthday;
  dynamic get designation => _designation;
  dynamic get company => _company;
  dynamic get department => _department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeCount'] = _employeeCount;
    map['clockOutCount'] = _clockOutCount;
    map['hour'] = _hour;
    map['upcoming_birthday'] = _upcomingBirthday;
    map['designation'] = _designation;
    map['company'] = _company;
    map['department'] = _department;
    return map;
  }

}