import 'EmployeeDetail.dart';

/// id : 3
/// company_id : 1
/// name : "Muhammad Ahsan"
/// email : "ahsan@gmail.com"
/// two_factor_secret : null
/// two_factor_recovery_codes : null
/// two_factor_confirmed : 0
/// two_factor_email_confirmed : 0
/// image : "3790c9b35d50070a300fde77f996ee24.png"
/// country_phonecode : 966
/// mobile : null
/// gender : "male"
/// salutation : "mr"
/// locale : "ar"
/// status : "active"
/// login : "enable"
/// onesignal_player_id : null
/// last_login : "2024-01-25T05:55:44+00:00"
/// email_notifications : 1
/// country_id : null
/// dark_theme : 0
/// rtl : 1
/// two_fa_verify_via : null
/// two_factor_code : null
/// two_factor_expires_at : null
/// admin_approval : 1
/// permission_sync : 1
/// google_calendar_status : 1
/// customised_permissions : 0
/// stripe_id : null
/// pm_type : null
/// pm_last_four : null
/// trial_ends_at : null
/// qr_image : "https://dashboard.radiusapp.online/users/qrcodes/Muhammad Ahsan.svg"
/// image_url : "https://dashboard.radiusapp.online/user-uploads/avatar/3790c9b35d50070a300fde77f996ee24.png"
/// modules : ["clients","projects","messages","tasks","timelogs","notices","employees","attendance","leaves","reports","settings","asset","payroll","restapi"]
/// mobile_with_phonecode : "--"
/// client_details : null
/// employee_detail : {"id":3,"company_id":1,"user_id":3,"employee_id":"3","address":null,"hourly_rate":0.0200000000000000004163336342344337026588618755340576171875,"slack_username":null,"department_id":2,"designation_id":2,"joining_date":"2023-12-07T00:00:00+00:00","last_date":null,"added_by":3,"last_updated_by":1,"attendance_reminder":null,"date_of_birth":null,"calendar_view":"task,events,holiday,tickets,leaves","about_me":null,"reporting_to":1,"contract_end_date":null,"internship_end_date":null,"employment_type":null,"marriage_anniversary_date":null,"marital_status":"unmarried","notice_period_end_date":null,"notice_period_start_date":null,"probation_end_date":null,"iqama_expiry":null,"city":"","upcoming_birthday":null,"designation":{"id":2,"company_id":1,"name":"Usher","parent_id":null,"added_by":null,"last_updated_by":null},"company":{"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":1,"timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":1,"google_map_key":null,"task_self":"yes","rounded_theme":1,"logo_background_color":"#000000","header_color":"#000000","before_days":0,"after_days":0,"on_deadline":"yes","default_task_status":1,"dashboard_clock":0,"ticket_form_google_captcha":0,"lead_form_google_captcha":0,"taskboard_length":10,"datatable_row_limit":10,"allow_client_signup":0,"admin_client_signup_approval":0,"google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":0,"show_new_webhook_alert":0,"pm_type":null,"pm_last_four":null,"employee_can_export_data":0,"logo_url":"https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png","login_background_url":"https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"},"department":{"id":2,"company_id":1,"team_name":"Event Name","parent_id":null,"added_by":null,"last_updated_by":null}}
/// leaves : []

class Ushers {
  Ushers({
      this.id, 
      this.companyId, 
      this.name, 
      this.email, 
      this.iqamaId,
      this.twoFactorSecret,
      this.twoFactorRecoveryCodes, 
      this.twoFactorConfirmed, 
      this.twoFactorEmailConfirmed, 
      this.image, 
      this.countryPhonecode, 
      this.mobile, 
      this.whatsappNumber,
      this.whatsappNumberCountryCode,
      this.gender,
      this.salutation, 
      this.locale, 
      this.status, 
      this.login, 
      this.onesignalPlayerId, 
      this.lastLogin, 
      this.emailNotifications, 
      this.countryId, 
      this.darkTheme, 
      this.rtl, 
      this.twoFaVerifyVia, 
      this.twoFactorCode, 
      this.twoFactorExpiresAt, 
      this.adminApproval, 
      this.permissionSync, 
      this.googleCalendarStatus, 
      this.customisedPermissions, 
      this.stripeId, 
      this.pmType, 
      this.pmLastFour, 
      this.trialEndsAt, 
      this.qrImage, 
      this.imageUrl, 
      this.modules, 
      this.mobileWithPhonecode, 
      this.clientDetails, 
      this.employeeDetail, 
      this.checkIn,
      this.alertMessage,
      this.jobName,
      this.leaves,});

  Ushers.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    alertMessage = json['alert_message'];
    email = json['email'];
    jobName = json['job_name'];
    checkIn = json['checkIn'];
    whatsappNumber = json['whatsapp_number'];
    whatsappNumberCountryCode = json['whatsapp_number_country_code'];
    mobile = json['mobile'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmed = json['two_factor_confirmed'];
    twoFactorEmailConfirmed = json['two_factor_email_confirmed'];
    image = json['image'];
    iqamaId = json['iqama_id'];
    countryPhonecode = json['country_phonecode'].toString()??"";

    gender = json['gender'];
    salutation = json['salutation'];
    locale = json['locale'];
    status = json['status'];
    login = json['login'];
    onesignalPlayerId = json['onesignal_player_id'];
    lastLogin = json['last_login'];
    emailNotifications = json['email_notifications'];
    countryId = json['country_id'];
    darkTheme = json['dark_theme'];
    rtl = json['rtl'];
    twoFaVerifyVia = json['two_fa_verify_via'];
    twoFactorCode = json['two_factor_code'];
    twoFactorExpiresAt = json['two_factor_expires_at'];
    adminApproval = json['admin_approval'];
    permissionSync = json['permission_sync'];
    googleCalendarStatus = json['google_calendar_status'];
    customisedPermissions = json['customised_permissions'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    qrImage = json['qr_image'];
    imageUrl = json['image_url'];
    modules = json['modules'] != null ? json['modules'].cast<String>() : [];
    mobileWithPhonecode = json['mobile_with_phonecode'];
    clientDetails = json['client_details'];
    employeeDetail = json['employee_detail'] != null ? EmployeeDetail.fromJson(json['employee_detail']) : null;

  }
  int? id;
  int? companyId;
  String? name;
  String? email;
  String? iqamaId;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  int? twoFactorConfirmed;
  int? twoFactorEmailConfirmed;
  String? checkIn;
  String? jobName;
  String? alertMessage;
  String? image;
  String? countryPhonecode;
  String ?mobile;
  String ?whatsappNumber;
  String ?whatsappNumberCountryCode;
  String? gender;
  String? salutation;
  String? locale;
  String? status;
  String? login;
  dynamic onesignalPlayerId;
  String? lastLogin;
  int? emailNotifications;
  dynamic countryId;
  int? darkTheme;
  int? rtl;
  dynamic twoFaVerifyVia;
  dynamic twoFactorCode;
  dynamic twoFactorExpiresAt;
  int? adminApproval;
  int? permissionSync;
  int? googleCalendarStatus;
  int? customisedPermissions;
  dynamic stripeId;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  String? qrImage;
  String? imageUrl;
  List<String>? modules;
  String? mobileWithPhonecode;
  dynamic clientDetails;
  EmployeeDetail? employeeDetail;
  List<dynamic>? leaves;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['name'] = name;
    map['email'] = email;
    map['two_factor_secret'] = twoFactorSecret;
    map['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    map['two_factor_confirmed'] = twoFactorConfirmed;
    map['two_factor_email_confirmed'] = twoFactorEmailConfirmed;
    map['image'] = image;
    map['country_phonecode'] = countryPhonecode;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['salutation'] = salutation;
    map['locale'] = locale;
    map['status'] = status;
    map['login'] = login;
    map['onesignal_player_id'] = onesignalPlayerId;
    map['last_login'] = lastLogin;
    map['email_notifications'] = emailNotifications;
    map['country_id'] = countryId;
    map['dark_theme'] = darkTheme;
    map['rtl'] = rtl;
    map['two_fa_verify_via'] = twoFaVerifyVia;
    map['two_factor_code'] = twoFactorCode;
    map['two_factor_expires_at'] = twoFactorExpiresAt;
    map['admin_approval'] = adminApproval;
    map['permission_sync'] = permissionSync;
    map['google_calendar_status'] = googleCalendarStatus;
    map['customised_permissions'] = customisedPermissions;
    map['stripe_id'] = stripeId;
    map['pm_type'] = pmType;
    map['pm_last_four'] = pmLastFour;
    map['trial_ends_at'] = trialEndsAt;
    map['qr_image'] = qrImage;
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