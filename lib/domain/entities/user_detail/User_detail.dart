import 'EmployeeDetail.dart';

/// id : 1
/// name : "Ahsan Zahid"
/// email : "ahsanzahid.devb@gmail.com"
/// status : "active"
/// qr_image : "https://radius.epic-sa.com/public/users/qrcodes/Ahsan Zahid.svg"
/// client_details : null
/// employee_detail : {"id":1,"company_id":"1","user_id":"1","employee_id":"1","address":null,"hourly_rate":null,"slack_username":null,"department_id":null,"designation_id":null,"joining_date":"2023-12-07T00:32:33+00:00","last_date":null,"added_by":null,"last_updated_by":"1","attendance_reminder":null,"date_of_birth":null,"calendar_view":null,"about_me":null,"reporting_to":null,"contract_end_date":null,"internship_end_date":null,"employment_type":null,"marriage_anniversary_date":null,"marital_status":"unmarried","notice_period_end_date":null,"notice_period_start_date":null,"probation_end_date":null,"upcoming_birthday":null,"designation":null,"company":{"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":"1","timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":"1","google_map_key":null,"task_self":"yes","rounded_theme":"1","logo_background_color":"#000000","header_color":"#000000","before_days":"0","after_days":"0","on_deadline":"yes","default_task_status":"1","dashboard_clock":"0","ticket_form_google_captcha":"0","lead_form_google_captcha":"0","taskboard_length":"10","datatable_row_limit":"10","allow_client_signup":"0","admin_client_signup_approval":"0","google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":"0","show_new_webhook_alert":"0","pm_type":null,"pm_last_four":null,"employee_can_export_data":"0","logo_url":"https://radius.epic-sa.com/public/user-uploads/app-logo/24d5a8e397be700c63fb55d415b3a086.png","login_background_url":"https://radius.epic-sa.com/public/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://radius.epic-sa.com/public/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"},"department":null}
/// leaves : []

class UserDetail {
  UserDetail({
      this.id, 
      this.name, 
      this.email, 
      this.status, 
      this.qrImage, 
      this.clientDetails, 
      this.employeeDetail, 
      this.leaves,});

  UserDetail.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    qrImage = json['qr_image'];
    clientDetails = json['client_details'];
    employeeDetail = json['employee_detail'] != null ? EmployeeDetail.fromJson(json['employee_detail']) : null;
    /*if (json['leaves'] != null) {
      leaves = [];
      json['leaves'].forEach((v) {
        leaves?.add(Dynamic.fromJson(v));
      });
    }*/
  }
  int? id;
  String? name;
  String? email;
  String? status;
  String? qrImage;
  dynamic clientDetails;
  EmployeeDetail? employeeDetail;
  List<dynamic>? leaves;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['status'] = status;
    map['qr_image'] = qrImage;
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