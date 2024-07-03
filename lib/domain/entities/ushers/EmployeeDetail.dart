import 'Designation.dart';
import 'Company.dart';
import 'Department.dart';

/// id : 3
/// company_id : 1
/// user_id : 3
/// employee_id : "3"
/// address : null
/// hourly_rate : 0.0200000000000000004163336342344337026588618755340576171875
/// slack_username : null
/// department_id : 2
/// designation_id : 2
/// joining_date : "2023-12-07T00:00:00+00:00"
/// last_date : null
/// added_by : 3
/// last_updated_by : 1
/// attendance_reminder : null
/// date_of_birth : null
/// calendar_view : "task,events,holiday,tickets,leaves"
/// about_me : null
/// reporting_to : 1
/// contract_end_date : null
/// internship_end_date : null
/// employment_type : null
/// marriage_anniversary_date : null
/// marital_status : "unmarried"
/// notice_period_end_date : null
/// notice_period_start_date : null
/// probation_end_date : null
/// iqama_expiry : null
/// city : ""
/// upcoming_birthday : null
/// designation : {"id":2,"company_id":1,"name":"Usher","parent_id":null,"added_by":null,"last_updated_by":null}
/// company : {"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":1,"timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":1,"google_map_key":null,"task_self":"yes","rounded_theme":1,"logo_background_color":"#000000","header_color":"#000000","before_days":0,"after_days":0,"on_deadline":"yes","default_task_status":1,"dashboard_clock":0,"ticket_form_google_captcha":0,"lead_form_google_captcha":0,"taskboard_length":10,"datatable_row_limit":10,"allow_client_signup":0,"admin_client_signup_approval":0,"google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":0,"show_new_webhook_alert":0,"pm_type":null,"pm_last_four":null,"employee_can_export_data":0,"logo_url":"https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png","login_background_url":"https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"}
/// department : {"id":2,"company_id":1,"team_name":"Event Name","parent_id":null,"added_by":null,"last_updated_by":null}

class EmployeeDetail {
  EmployeeDetail({
      this.id, 
      this.companyId, 
      this.userId, 
      this.employeeId, 
      this.address, 
      this.hourlyRate, 
      this.slackUsername, 
      this.departmentId, 
      this.designationId, 
      this.joiningDate, 
      this.lastDate, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.attendanceReminder, 
      this.dateOfBirth, 
      this.calendarView, 
      this.aboutMe, 
      this.reportingTo, 
      this.contractEndDate, 
      this.internshipEndDate, 
      this.employmentType, 
      this.marriageAnniversaryDate, 
      this.maritalStatus, 
      this.noticePeriodEndDate, 
      this.noticePeriodStartDate, 
      this.probationEndDate, 
      this.iqamaExpiry, 
      this.city, 
      this.upcomingBirthday, 
      this.designation, 
      this.company, 
      this.department,});

  EmployeeDetail.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    address = json['address'];
    hourlyRate = json['hourly_rate'];
    slackUsername = json['slack_username'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    joiningDate = json['joining_date'];
    lastDate = json['last_date'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    attendanceReminder = json['attendance_reminder'];
    dateOfBirth = json['date_of_birth'];
    calendarView = json['calendar_view'];
    aboutMe = json['about_me'];
    reportingTo = json['reporting_to'];
    contractEndDate = json['contract_end_date'];
    internshipEndDate = json['internship_end_date'];
    employmentType = json['employment_type'];
    marriageAnniversaryDate = json['marriage_anniversary_date'];
    maritalStatus = json['marital_status'];
    noticePeriodEndDate = json['notice_period_end_date'];
    noticePeriodStartDate = json['notice_period_start_date'];
    probationEndDate = json['probation_end_date'];
    iqamaExpiry = json['iqama_expiry'];
    city = json['city'];
    upcomingBirthday = json['upcoming_birthday'];
    designation = json['designation'] != null ? Designation.fromJson(json['designation']) : null;
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    department = json['department'] != null ? Department.fromJson(json['department']) : null;
  }
  int? id;
  int? companyId;
  int? userId;
  String? employeeId;
  dynamic address;
  double? hourlyRate;
  dynamic slackUsername;
  int? departmentId;
  int? designationId;
  String? joiningDate;
  dynamic lastDate;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic attendanceReminder;
  dynamic dateOfBirth;
  String? calendarView;
  dynamic aboutMe;
  int? reportingTo;
  dynamic contractEndDate;
  dynamic internshipEndDate;
  dynamic employmentType;
  dynamic marriageAnniversaryDate;
  String? maritalStatus;
  dynamic noticePeriodEndDate;
  dynamic noticePeriodStartDate;
  dynamic probationEndDate;
  dynamic iqamaExpiry;
  String? city;
  dynamic upcomingBirthday;
  Designation? designation;
  Company? company;
  Department? department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['user_id'] = userId;
    map['employee_id'] = employeeId;
    map['address'] = address;
    map['hourly_rate'] = hourlyRate;
    map['slack_username'] = slackUsername;
    map['department_id'] = departmentId;
    map['designation_id'] = designationId;
    map['joining_date'] = joiningDate;
    map['last_date'] = lastDate;
    map['added_by'] = addedBy;
    map['last_updated_by'] = lastUpdatedBy;
    map['attendance_reminder'] = attendanceReminder;
    map['date_of_birth'] = dateOfBirth;
    map['calendar_view'] = calendarView;
    map['about_me'] = aboutMe;
    map['reporting_to'] = reportingTo;
    map['contract_end_date'] = contractEndDate;
    map['internship_end_date'] = internshipEndDate;
    map['employment_type'] = employmentType;
    map['marriage_anniversary_date'] = marriageAnniversaryDate;
    map['marital_status'] = maritalStatus;
    map['notice_period_end_date'] = noticePeriodEndDate;
    map['notice_period_start_date'] = noticePeriodStartDate;
    map['probation_end_date'] = probationEndDate;
    map['iqama_expiry'] = iqamaExpiry;
    map['city'] = city;
    map['upcoming_birthday'] = upcomingBirthday;
    if (designation != null) {
      map['designation'] = designation?.toJson();
    }
    if (company != null) {
      map['company'] = company?.toJson();
    }
    if (department != null) {
      map['department'] = department?.toJson();
    }
    return map;
  }

}