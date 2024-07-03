import 'EmployeeDetail.dart';

/// name : "Ali123"
/// email : "ali@gmail.com"
/// id : 104
/// image_url : "https://www.gravatar.com/avatar/d4384c2e7aab2c22eb805c0f48852f23.png?s=200&d=mp"
/// modules : ["projects","messages","tasks","timelogs","notices","settings"]
/// mobile_with_phonecode : "--"
/// client_details : null
/// employee_detail : {"id":156,"company_id":1,"user_id":104,"employee_id":"144","address":null,"hourly_rate":null,"slack_username":null,"department_id":3,"designation_id":4,"joining_date":"2024-01-18T00:00:00+00:00","last_date":null,"added_by":1,"last_updated_by":1,"attendance_reminder":null,"date_of_birth":null,"calendar_view":"task,events,holiday,tickets,leaves","about_me":null,"reporting_to":null,"contract_end_date":null,"internship_end_date":null,"employment_type":null,"marriage_anniversary_date":null,"marital_status":"unmarried","notice_period_end_date":null,"notice_period_start_date":null,"probation_end_date":null,"iqama_expiry":null,"city":"","upcoming_birthday":null,"designation":{"id":4,"company_id":1,"name":"Supervisor","parent_id":null,"added_by":null,"last_updated_by":null},"company":{"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":1,"timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":1,"google_map_key":null,"task_self":"yes","rounded_theme":1,"logo_background_color":"#000000","header_color":"#000000","before_days":0,"after_days":0,"on_deadline":"yes","default_task_status":1,"dashboard_clock":0,"ticket_form_google_captcha":0,"lead_form_google_captcha":0,"taskboard_length":10,"datatable_row_limit":10,"allow_client_signup":0,"admin_client_signup_approval":0,"google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":0,"show_new_webhook_alert":0,"pm_type":null,"pm_last_four":null,"employee_can_export_data":0,"logo_url":"https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png","login_background_url":"https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"},"department":{"id":3,"company_id":1,"team_name":"CR7","parent_id":null,"added_by":null,"last_updated_by":null}}
/// leaves : []

class Manager {
  Manager({
      this.name, 
      this.email, 
      this.id, 
      this.imageUrl, 
      this.modules, 
      this.mobileWithPhonecode, 
      this.clientDetails, 
      this.employeeDetail, 
      this.leaves,});

  Manager.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    imageUrl = json['image_url'];
    modules = json['modules'] != null ? json['modules'].cast<String>() : [];
    mobileWithPhonecode = json['mobile_with_phonecode'];
    clientDetails = json['client_details'];
    employeeDetail = json['employee_detail'] != null ? EmployeeDetail.fromJson(json['employee_detail']) : null;

  }
  String? name;
  String? email;
  int? id;
  String? imageUrl;
  List<String>? modules;
  String? mobileWithPhonecode;
  dynamic clientDetails;
  EmployeeDetail? employeeDetail;
  List<dynamic>? leaves;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['id'] = id;
    map['image_url'] = imageUrl;
    map['modules'] = modules;
    map['mobile_with_phonecode'] = mobileWithPhonecode;
    map['client_details'] = clientDetails;
    if (employeeDetail != null) {
      map['employee_detail'] = employeeDetail?.toJson();
    }
    if (leaves != null) {
      map['leaves'] = leaves?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}