/// id : 1
/// company_name : "Radius"
/// app_name : "Radius"
/// company_email : "radius@email.com"
/// company_phone : "1234567891"
/// logo : "24d5a8e397be700c63fb55d415b3a086.png"
/// light_logo : "003cf449dade46889872e9ff40339106.png"
/// favicon : "7bc113efe84bf23cae8dc30c0e5ee143.png"
/// auth_theme : "light"
/// auth_theme_text : "light"
/// sidebar_logo_style : "square"
/// login_background : "9c3b77ae68f0b1e014ac25b60dd7b1f9.png"
/// address : "Your Company address here"
/// website : null
/// currency_id : 1
/// timezone : "Asia/Karachi"
/// date_format : "d-m-Y"
/// date_picker_format : "dd-mm-yyyy"
/// year_starts_from : "1"
/// moment_format : "DD-MM-YYYY"
/// time_format : "h:i a"
/// locale : "en"
/// latitude : "26.91243360"
/// longitude : "75.78727090"
/// leaves_start_from : "joining_date"
/// active_theme : "default"
/// status : "active"
/// last_updated_by : 1
/// google_map_key : null
/// task_self : "yes"
/// rounded_theme : 1
/// logo_background_color : "#000000"
/// header_color : "#000000"
/// before_days : 0
/// after_days : 0
/// on_deadline : "yes"
/// default_task_status : 1
/// dashboard_clock : 0
/// ticket_form_google_captcha : 0
/// lead_form_google_captcha : 0
/// taskboard_length : 10
/// datatable_row_limit : 10
/// allow_client_signup : 0
/// admin_client_signup_approval : 0
/// google_calendar_status : "inactive"
/// google_client_id : null
/// google_client_secret : null
/// google_calendar_verification_status : "non_verified"
/// google_id : null
/// name : null
/// token : null
/// hash : "6b3e630e4ca096c89c90440492ce808c"
/// last_login : null
/// rtl : 0
/// show_new_webhook_alert : 0
/// pm_type : null
/// pm_last_four : null
/// employee_can_export_data : 0
/// logo_url : "https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png"
/// login_background_url : "https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png"
/// moment_date_format : "DD-MM-YYYY"
/// favicon_url : "https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"

class Company {
  Company({
      this.id, 
      this.companyName, 
      this.appName, 
      this.companyEmail, 
      this.companyPhone, 
      this.logo, 
      this.lightLogo, 
      this.favicon, 
      this.authTheme, 
      this.authThemeText, 
      this.sidebarLogoStyle, 
      this.loginBackground, 
      this.address, 
      this.website, 
      this.currencyId, 
      this.timezone, 
      this.dateFormat, 
      this.datePickerFormat, 
      this.yearStartsFrom, 
      this.momentFormat, 
      this.timeFormat, 
      this.locale, 
      this.latitude, 
      this.longitude, 
      this.leavesStartFrom, 
      this.activeTheme, 
      this.status, 
      this.lastUpdatedBy, 
      this.googleMapKey, 
      this.taskSelf, 
      this.roundedTheme, 
      this.logoBackgroundColor, 
      this.headerColor, 
      this.beforeDays, 
      this.afterDays, 
      this.onDeadline, 
      this.defaultTaskStatus, 
      this.dashboardClock, 
      this.ticketFormGoogleCaptcha, 
      this.leadFormGoogleCaptcha, 
      this.taskboardLength, 
      this.datatableRowLimit, 
      this.allowClientSignup, 
      this.adminClientSignupApproval, 
      this.googleCalendarStatus, 
      this.googleClientId, 
      this.googleClientSecret, 
      this.googleCalendarVerificationStatus, 
      this.googleId, 
      this.name, 
      this.token, 
      this.hash, 
      this.lastLogin, 
      this.rtl, 
      this.showNewWebhookAlert, 
      this.pmType, 
      this.pmLastFour, 
      this.employeeCanExportData, 
      this.logoUrl, 
      this.loginBackgroundUrl, 
      this.momentDateFormat, 
      this.faviconUrl,});

  Company.fromJson(dynamic json) {
    id = json['id'];
    companyName = json['company_name'];
    appName = json['app_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    logo = json['logo'];
    lightLogo = json['light_logo'];
    favicon = json['favicon'];
    authTheme = json['auth_theme'];
    authThemeText = json['auth_theme_text'];
    sidebarLogoStyle = json['sidebar_logo_style'];
    loginBackground = json['login_background'];
    address = json['address'];
    website = json['website'];
    currencyId = json['currency_id'];
    timezone = json['timezone'];
    dateFormat = json['date_format'];
    datePickerFormat = json['date_picker_format'];
    yearStartsFrom = json['year_starts_from'];
    momentFormat = json['moment_format'];
    timeFormat = json['time_format'];
    locale = json['locale'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    leavesStartFrom = json['leaves_start_from'];
    activeTheme = json['active_theme'];
    status = json['status'];
    lastUpdatedBy = json['last_updated_by'];
    googleMapKey = json['google_map_key'];
    taskSelf = json['task_self'];
    roundedTheme = json['rounded_theme'];
    logoBackgroundColor = json['logo_background_color'];
    headerColor = json['header_color'];
    beforeDays = json['before_days'];
    afterDays = json['after_days'];
    onDeadline = json['on_deadline'];
    defaultTaskStatus = json['default_task_status'];
    dashboardClock = json['dashboard_clock'];
    ticketFormGoogleCaptcha = json['ticket_form_google_captcha'];
    leadFormGoogleCaptcha = json['lead_form_google_captcha'];
    taskboardLength = json['taskboard_length'];
    datatableRowLimit = json['datatable_row_limit'];
    allowClientSignup = json['allow_client_signup'];
    adminClientSignupApproval = json['admin_client_signup_approval'];
    googleCalendarStatus = json['google_calendar_status'];
    googleClientId = json['google_client_id'];
    googleClientSecret = json['google_client_secret'];
    googleCalendarVerificationStatus = json['google_calendar_verification_status'];
    googleId = json['google_id'];
    name = json['name'];
    token = json['token'];
    hash = json['hash'];
    lastLogin = json['last_login'];
    rtl = json['rtl'];
    showNewWebhookAlert = json['show_new_webhook_alert'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    employeeCanExportData = json['employee_can_export_data'];
    logoUrl = json['logo_url'];
    loginBackgroundUrl = json['login_background_url'];
    momentDateFormat = json['moment_date_format'];
    faviconUrl = json['favicon_url'];
  }
  int? id;
  String? companyName;
  String? appName;
  String? companyEmail;
  String? companyPhone;
  String? logo;
  String? lightLogo;
  String? favicon;
  String? authTheme;
  String? authThemeText;
  String? sidebarLogoStyle;
  String? loginBackground;
  String? address;
  dynamic website;
  int? currencyId;
  String? timezone;
  String? dateFormat;
  String? datePickerFormat;
  String? yearStartsFrom;
  String? momentFormat;
  String? timeFormat;
  String? locale;
  String? latitude;
  String? longitude;
  String? leavesStartFrom;
  String? activeTheme;
  String? status;
  int? lastUpdatedBy;
  dynamic googleMapKey;
  String? taskSelf;
  int? roundedTheme;
  String? logoBackgroundColor;
  String? headerColor;
  int? beforeDays;
  int? afterDays;
  String? onDeadline;
  int? defaultTaskStatus;
  int? dashboardClock;
  int? ticketFormGoogleCaptcha;
  int? leadFormGoogleCaptcha;
  int? taskboardLength;
  int? datatableRowLimit;
  int? allowClientSignup;
  int? adminClientSignupApproval;
  String? googleCalendarStatus;
  dynamic googleClientId;
  dynamic googleClientSecret;
  String? googleCalendarVerificationStatus;
  dynamic googleId;
  dynamic name;
  dynamic token;
  String? hash;
  dynamic lastLogin;
  int? rtl;
  int? showNewWebhookAlert;
  dynamic pmType;
  dynamic pmLastFour;
  int? employeeCanExportData;
  String? logoUrl;
  String? loginBackgroundUrl;
  String? momentDateFormat;
  String? faviconUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_name'] = companyName;
    map['app_name'] = appName;
    map['company_email'] = companyEmail;
    map['company_phone'] = companyPhone;
    map['logo'] = logo;
    map['light_logo'] = lightLogo;
    map['favicon'] = favicon;
    map['auth_theme'] = authTheme;
    map['auth_theme_text'] = authThemeText;
    map['sidebar_logo_style'] = sidebarLogoStyle;
    map['login_background'] = loginBackground;
    map['address'] = address;
    map['website'] = website;
    map['currency_id'] = currencyId;
    map['timezone'] = timezone;
    map['date_format'] = dateFormat;
    map['date_picker_format'] = datePickerFormat;
    map['year_starts_from'] = yearStartsFrom;
    map['moment_format'] = momentFormat;
    map['time_format'] = timeFormat;
    map['locale'] = locale;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['leaves_start_from'] = leavesStartFrom;
    map['active_theme'] = activeTheme;
    map['status'] = status;
    map['last_updated_by'] = lastUpdatedBy;
    map['google_map_key'] = googleMapKey;
    map['task_self'] = taskSelf;
    map['rounded_theme'] = roundedTheme;
    map['logo_background_color'] = logoBackgroundColor;
    map['header_color'] = headerColor;
    map['before_days'] = beforeDays;
    map['after_days'] = afterDays;
    map['on_deadline'] = onDeadline;
    map['default_task_status'] = defaultTaskStatus;
    map['dashboard_clock'] = dashboardClock;
    map['ticket_form_google_captcha'] = ticketFormGoogleCaptcha;
    map['lead_form_google_captcha'] = leadFormGoogleCaptcha;
    map['taskboard_length'] = taskboardLength;
    map['datatable_row_limit'] = datatableRowLimit;
    map['allow_client_signup'] = allowClientSignup;
    map['admin_client_signup_approval'] = adminClientSignupApproval;
    map['google_calendar_status'] = googleCalendarStatus;
    map['google_client_id'] = googleClientId;
    map['google_client_secret'] = googleClientSecret;
    map['google_calendar_verification_status'] = googleCalendarVerificationStatus;
    map['google_id'] = googleId;
    map['name'] = name;
    map['token'] = token;
    map['hash'] = hash;
    map['last_login'] = lastLogin;
    map['rtl'] = rtl;
    map['show_new_webhook_alert'] = showNewWebhookAlert;
    map['pm_type'] = pmType;
    map['pm_last_four'] = pmLastFour;
    map['employee_can_export_data'] = employeeCanExportData;
    map['logo_url'] = logoUrl;
    map['login_background_url'] = loginBackgroundUrl;
    map['moment_date_format'] = momentDateFormat;
    map['favicon_url'] = faviconUrl;
    return map;
  }

}