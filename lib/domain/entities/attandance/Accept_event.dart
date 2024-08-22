class AcceptEvent {
  bool? success;
  Detail? detail;

  AcceptEvent({this.success, this.detail});

  AcceptEvent.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class Detail {
  int? currentPage;
  List<Data>? data;
  var firstPageUrl;
  int? from;
  int? lastPage;
  var lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  var path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  Detail(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Detail.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? eventModelId;
  int? eventZoneJobId;
  int? userId;
  var invitationCount;
  var rejectionCount;
  var status;
  var createdAt;
  var updatedAt;
  bool? approveStatus;
  IsUserOut? isUserOut;
  User? user;
  EventModel? eventModel;

  Data(
      {this.id,
        this.eventModelId,
        this.eventZoneJobId,
        this.userId,
        this.invitationCount,
        this.rejectionCount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.approveStatus,
        this.isUserOut,
        this.user,
        this.eventModel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    eventZoneJobId = json['event_zone_job_id'];
    userId = json['user_id'];
    invitationCount = json['invitation_count'];
    rejectionCount = json['rejection_count'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approveStatus = json['approve_status'];
    isUserOut = json['is_user_out'] != null
        ? new IsUserOut.fromJson(json['is_user_out'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    eventModel = json['event_model'] != null
        ? new EventModel.fromJson(json['event_model'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_model_id'] = this.eventModelId;
    data['event_zone_job_id'] = this.eventZoneJobId;
    data['user_id'] = this.userId;
    data['invitation_count'] = this.invitationCount;
    data['rejection_count'] = this.rejectionCount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['approve_status'] = this.approveStatus;
    if (this.isUserOut != null) {
      data['is_user_out'] = this.isUserOut!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.eventModel != null) {
      data['event_model'] = this.eventModel!.toJson();
    }
    return data;
  }
}

class IsUserOut {
  var distance;
  bool? isOut;

  IsUserOut({this.distance, this.isOut});

  IsUserOut.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    isOut = json['isOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['isOut'] = this.isOut;
    return data;
  }
}

class User {
  int? id;
  int? companyId;
  var name;
  var email;
  var twoFactorSecret;
  var twoFactorRecoveryCodes;
  int? twoFactorConfirmed;
  int? twoFactorEmailConfirmed;
  var image;
  var countryPhonecode;
  var mobile;
  var gender;
  var salutation;
  var locale;
  var status;
  var login;
  var onesignalPlayerId;
  var lastLogin;
  int? emailNotifications;
  var countryId;
  int? darkTheme;
  int? rtl;
  var twoFaVerifyVia;
  var twoFactorCode;
  var twoFactorExpiresAt;
  int? adminApproval;
  int? permissionSync;
  int? googleCalendarStatus;
  int? customisedPermissions;
  var stripeId;
  var pmType;
  var pmLastFour;
  var trialEndsAt;
  var qrImage;
  var deviceToken;
  var whatsappNumber;
  var whatsappNumberCountryCode;
  var latitude;
  var longitude;
  var deviceId;
  var deviceName;
  int? isVerified;
  int? isBanned;
  var imageUrl;
  List<String>? modules;
  var mobileWithPhonecode;
  var jobName;
  var checkIn;
  var clientDetails;
  EmployeeDetail? employeeDetail;
  List<Null>? leaves;

  User(
      {this.id,
        this.companyId,
        this.name,
        this.email,
        this.twoFactorSecret,
        this.twoFactorRecoveryCodes,
        this.twoFactorConfirmed,
        this.twoFactorEmailConfirmed,
        this.image,
        this.countryPhonecode,
        this.mobile,
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
        this.deviceToken,
        this.whatsappNumber,
        this.whatsappNumberCountryCode,
        this.latitude,
        this.longitude,
        this.deviceId,
        this.deviceName,
        this.isVerified,
        this.isBanned,
        this.imageUrl,
        this.modules,
        this.mobileWithPhonecode,
        this.jobName,
        this.checkIn,
        this.clientDetails,
        this.employeeDetail,
        this.leaves});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    email = json['email'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmed = json['two_factor_confirmed'];
    twoFactorEmailConfirmed = json['two_factor_email_confirmed'];
    image = json['image'];
    countryPhonecode = json['country_phonecode'];
    mobile = json['mobile'];
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
    deviceToken = json['device_token'];
    whatsappNumber = json['whatsapp_number'];
    whatsappNumberCountryCode = json['whatsapp_number_country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    isVerified = json['is_verified'];
    isBanned = json['is_banned'];
    imageUrl = json['image_url'];
    modules = json['modules'].cast<String>();
    mobileWithPhonecode = json['mobile_with_phonecode'];
    jobName = json['job_name'];
    checkIn = json['checkIn'];
    clientDetails = json['client_details'];
    employeeDetail = json['employee_detail'] != null
        ? new EmployeeDetail.fromJson(json['employee_detail'])
        : null;
    if (json['leaves'] != null) {
      leaves = <Null>[];
      json['leaves'].forEach((v) {
        leaves!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['two_factor_confirmed'] = this.twoFactorConfirmed;
    data['two_factor_email_confirmed'] = this.twoFactorEmailConfirmed;
    data['image'] = this.image;
    data['country_phonecode'] = this.countryPhonecode;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['salutation'] = this.salutation;
    data['locale'] = this.locale;
    data['status'] = this.status;
    data['login'] = this.login;
    data['onesignal_player_id'] = this.onesignalPlayerId;
    data['last_login'] = this.lastLogin;
    data['email_notifications'] = this.emailNotifications;
    data['country_id'] = this.countryId;
    data['dark_theme'] = this.darkTheme;
    data['rtl'] = this.rtl;
    data['two_fa_verify_via'] = this.twoFaVerifyVia;
    data['two_factor_code'] = this.twoFactorCode;
    data['two_factor_expires_at'] = this.twoFactorExpiresAt;
    data['admin_approval'] = this.adminApproval;
    data['permission_sync'] = this.permissionSync;
    data['google_calendar_status'] = this.googleCalendarStatus;
    data['customised_permissions'] = this.customisedPermissions;
    data['stripe_id'] = this.stripeId;
    data['pm_type'] = this.pmType;
    data['pm_last_four'] = this.pmLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    data['qr_image'] = this.qrImage;
    data['device_token'] = this.deviceToken;
    data['whatsapp_number'] = this.whatsappNumber;
    data['whatsapp_number_country_code'] = this.whatsappNumberCountryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['device_id'] = this.deviceId;
    data['device_name'] = this.deviceName;
    data['is_verified'] = this.isVerified;
    data['is_banned'] = this.isBanned;
    data['image_url'] = this.imageUrl;
    data['modules'] = this.modules;
    data['mobile_with_phonecode'] = this.mobileWithPhonecode;
    data['job_name'] = this.jobName;
    data['checkIn'] = this.checkIn;
    data['client_details'] = this.clientDetails;
    if (this.employeeDetail != null) {
      data['employee_detail'] = this.employeeDetail!.toJson();
    }
    if (this.leaves != null) {
      data['leaves'] = this.leaves!.map((v) => v).toList();
    }
    return data;
  }
}

class EmployeeDetail {
  int? id;
  int? companyId;
  int? userId;
  var employeeId;
  var address;
  var hourlyRate;
  var slackUsername;
  int? departmentId;
  var designationId;
  var joiningDate;
  var lastDate;
  int? addedBy;
  int? lastUpdatedBy;
  var attendanceReminder;
  var dateOfBirth;
  var calendarView;
  var aboutMe;
  var reportingTo;
  var contractEndDate;
  var internshipEndDate;
  var employmentType;
  var marriageAnniversaryDate;
  var maritalStatus;
  var noticePeriodEndDate;
  var noticePeriodStartDate;
  var probationEndDate;
  var iqamaExpiry;
  var city;
  var upcomingBirthday;
  var designation;
  Company? company;
  Department? department;

  EmployeeDetail(
      {this.id,
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
        this.department});

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
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
    designation = json['designation'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['address'] = this.address;
    data['hourly_rate'] = this.hourlyRate;
    data['slack_username'] = this.slackUsername;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['joining_date'] = this.joiningDate;
    data['last_date'] = this.lastDate;
    data['added_by'] = this.addedBy;
    data['last_updated_by'] = this.lastUpdatedBy;
    data['attendance_reminder'] = this.attendanceReminder;
    data['date_of_birth'] = this.dateOfBirth;
    data['calendar_view'] = this.calendarView;
    data['about_me'] = this.aboutMe;
    data['reporting_to'] = this.reportingTo;
    data['contract_end_date'] = this.contractEndDate;
    data['internship_end_date'] = this.internshipEndDate;
    data['employment_type'] = this.employmentType;
    data['marriage_anniversary_date'] = this.marriageAnniversaryDate;
    data['marital_status'] = this.maritalStatus;
    data['notice_period_end_date'] = this.noticePeriodEndDate;
    data['notice_period_start_date'] = this.noticePeriodStartDate;
    data['probation_end_date'] = this.probationEndDate;
    data['iqama_expiry'] = this.iqamaExpiry;
    data['city'] = this.city;
    data['upcoming_birthday'] = this.upcomingBirthday;
    data['designation'] = this.designation;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  var companyName;
  var appName;
  var companyEmail;
  var companyPhone;
  var logo;
  var lightLogo;
  var favicon;
  var authTheme;
  var authThemeText;
  var sidebarLogoStyle;
  var loginBackground;
  var address;
  var website;
  int? currencyId;
  var timezone;
  var dateFormat;
  var datePickerFormat;
  var yearStartsFrom;
  var momentFormat;
  var timeFormat;
  var locale;
  var latitude;
  var longitude;
  var leavesStartFrom;
  var activeTheme;
  var status;
  int? lastUpdatedBy;
  var googleMapKey;
  var taskSelf;
  int? roundedTheme;
  var logoBackgroundColor;
  var headerColor;
  int? beforeDays;
  int? afterDays;
  var onDeadline;
  int? defaultTaskStatus;
  int? dashboardClock;
  int? ticketFormGoogleCaptcha;
  int? leadFormGoogleCaptcha;
  int? taskboardLength;
  int? datatableRowLimit;
  int? allowClientSignup;
  int? adminClientSignupApproval;
  var googleCalendarStatus;
  var googleClientId;
  var googleClientSecret;
  var googleCalendarVerificationStatus;
  var googleId;
  var name;
  var token;
  var hash;
  var lastLogin;
  int? rtl;
  int? showNewWebhookAlert;
  var pmType;
  var pmLastFour;
  int? employeeCanExportData;
  var appAndroidVersion;
  var appIosVersion;
  var logoUrl;
  var loginBackgroundUrl;
  var momentDateFormat;
  var faviconUrl;

  Company(
      {this.id,
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
        this.appAndroidVersion,
        this.appIosVersion,
        this.logoUrl,
        this.loginBackgroundUrl,
        this.momentDateFormat,
        this.faviconUrl});

  Company.fromJson(Map<String, dynamic> json) {
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
    googleCalendarVerificationStatus =
    json['google_calendar_verification_status'];
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
    appAndroidVersion = json['app_android_version'];
    appIosVersion = json['app_ios_version'];
    logoUrl = json['logo_url'];
    loginBackgroundUrl = json['login_background_url'];
    momentDateFormat = json['moment_date_format'];
    faviconUrl = json['favicon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['app_name'] = this.appName;
    data['company_email'] = this.companyEmail;
    data['company_phone'] = this.companyPhone;
    data['logo'] = this.logo;
    data['light_logo'] = this.lightLogo;
    data['favicon'] = this.favicon;
    data['auth_theme'] = this.authTheme;
    data['auth_theme_text'] = this.authThemeText;
    data['sidebar_logo_style'] = this.sidebarLogoStyle;
    data['login_background'] = this.loginBackground;
    data['address'] = this.address;
    data['website'] = this.website;
    data['currency_id'] = this.currencyId;
    data['timezone'] = this.timezone;
    data['date_format'] = this.dateFormat;
    data['date_picker_format'] = this.datePickerFormat;
    data['year_starts_from'] = this.yearStartsFrom;
    data['moment_format'] = this.momentFormat;
    data['time_format'] = this.timeFormat;
    data['locale'] = this.locale;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['leaves_start_from'] = this.leavesStartFrom;
    data['active_theme'] = this.activeTheme;
    data['status'] = this.status;
    data['last_updated_by'] = this.lastUpdatedBy;
    data['google_map_key'] = this.googleMapKey;
    data['task_self'] = this.taskSelf;
    data['rounded_theme'] = this.roundedTheme;
    data['logo_background_color'] = this.logoBackgroundColor;
    data['header_color'] = this.headerColor;
    data['before_days'] = this.beforeDays;
    data['after_days'] = this.afterDays;
    data['on_deadline'] = this.onDeadline;
    data['default_task_status'] = this.defaultTaskStatus;
    data['dashboard_clock'] = this.dashboardClock;
    data['ticket_form_google_captcha'] = this.ticketFormGoogleCaptcha;
    data['lead_form_google_captcha'] = this.leadFormGoogleCaptcha;
    data['taskboard_length'] = this.taskboardLength;
    data['datatable_row_limit'] = this.datatableRowLimit;
    data['allow_client_signup'] = this.allowClientSignup;
    data['admin_client_signup_approval'] = this.adminClientSignupApproval;
    data['google_calendar_status'] = this.googleCalendarStatus;
    data['google_client_id'] = this.googleClientId;
    data['google_client_secret'] = this.googleClientSecret;
    data['google_calendar_verification_status'] =
        this.googleCalendarVerificationStatus;
    data['google_id'] = this.googleId;
    data['name'] = this.name;
    data['token'] = this.token;
    data['hash'] = this.hash;
    data['last_login'] = this.lastLogin;
    data['rtl'] = this.rtl;
    data['show_new_webhook_alert'] = this.showNewWebhookAlert;
    data['pm_type'] = this.pmType;
    data['pm_last_four'] = this.pmLastFour;
    data['employee_can_export_data'] = this.employeeCanExportData;
    data['app_android_version'] = this.appAndroidVersion;
    data['app_ios_version'] = this.appIosVersion;
    data['logo_url'] = this.logoUrl;
    data['login_background_url'] = this.loginBackgroundUrl;
    data['moment_date_format'] = this.momentDateFormat;
    data['favicon_url'] = this.faviconUrl;
    return data;
  }
}

class Department {
  int? id;
  int? companyId;
  var teamName;
  var code;
  var parentId;
  var addedBy;
  var lastUpdatedBy;

  Department(
      {this.id,
        this.companyId,
        this.teamName,
        this.code,
        this.parentId,
        this.addedBy,
        this.lastUpdatedBy});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    teamName = json['team_name'];
    code = json['code'];
    parentId = json['parent_id'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['team_name'] = this.teamName;
    data['code'] = this.code;
    data['parent_id'] = this.parentId;
    data['added_by'] = this.addedBy;
    data['last_updated_by'] = this.lastUpdatedBy;
    return data;
  }
}

class EventModel {
  int? id;
  var addedBy;
  var eventName;
  var logo;
  var countryId;
  var cityId;
  var district;
  var latitude;
  var longitude;
  var location;
  var radius;
  var startDate;
  var endDate;
  var startTime;
  var endTime;
  var managerId;
  var warehouseManagerId;
  var leadTime;
  var leadTimeUnit;
  var projectSummary;
  var termsCondition;
  var termsConditionArabic;
  var hiddenFields;
  var status;
  var completionPercent;
  var currencyId;
  var budget;
  var dayoff;
  var deletedAt;
  bool? isProjectAdmin;
  var fullAddress;
  var startDates;
  var endDates;
  List<Null>? members;
  Country? country;

  EventModel(
      {this.id,
        this.addedBy,
        this.eventName,
        this.logo,
        this.countryId,
        this.cityId,
        this.district,
        this.latitude,
        this.longitude,
        this.location,
        this.radius,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.managerId,
        this.warehouseManagerId,
        this.leadTime,
        this.leadTimeUnit,
        this.projectSummary,
        this.termsCondition,
        this.termsConditionArabic,
        this.hiddenFields,
        this.status,
        this.completionPercent,
        this.currencyId,
        this.budget,
        this.dayoff,
        this.deletedAt,
        this.isProjectAdmin,
        this.fullAddress,
        this.startDates,
        this.endDates,
        this.members,
        this.country});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    eventName = json['event_name'];
    logo = json['logo'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    district = json['district'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    radius = json['radius'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    managerId = json['manager_id'];
    warehouseManagerId = json['warehouse_manager_id'];
    leadTime = json['lead_time'];
    leadTimeUnit = json['lead_time_unit'];
    projectSummary = json['project_summary'];
    termsCondition = json['terms_condition'];
    termsConditionArabic = json['terms_condition_arabic'];
    hiddenFields = json['hidden_fields'];
    status = json['status'];
    completionPercent = json['completion_percent'];
    currencyId = json['currency_id'];
    budget = json['budget'];
    dayoff = json['dayoff'];
    deletedAt = json['deleted_at'];
    isProjectAdmin = json['isProjectAdmin'];
    fullAddress = json['full_address'];
    startDates = json['start_dates'];
    endDates = json['end_dates'];
    if (json['members'] != null) {
      members = <Null>[];
      json['members'].forEach((v) {
        members!.add((v));
      });
    }
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['event_name'] = this.eventName;
    data['logo'] = this.logo;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['radius'] = this.radius;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['manager_id'] = this.managerId;
    data['warehouse_manager_id'] = this.warehouseManagerId;
    data['lead_time'] = this.leadTime;
    data['lead_time_unit'] = this.leadTimeUnit;
    data['project_summary'] = this.projectSummary;
    data['terms_condition'] = this.termsCondition;
    data['terms_condition_arabic'] = this.termsConditionArabic;
    data['hidden_fields'] = this.hiddenFields;
    data['status'] = this.status;
    data['completion_percent'] = this.completionPercent;
    data['currency_id'] = this.currencyId;
    data['budget'] = this.budget;
    data['dayoff'] = this.dayoff;
    data['deleted_at'] = this.deletedAt;
    data['isProjectAdmin'] = this.isProjectAdmin;
    data['full_address'] = this.fullAddress;
    data['start_dates'] = this.startDates;
    data['end_dates'] = this.endDates;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  var iso;
  var name;
  var nicename;
  var iso3;
  int? numcode;
  int? phonecode;
  var nationality;

  Country(
      {this.id,
        this.iso,
        this.name,
        this.nicename,
        this.iso3,
        this.numcode,
        this.phonecode,
        this.nationality});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['nicename'] = this.nicename;
    data['iso3'] = this.iso3;
    data['numcode'] = this.numcode;
    data['phonecode'] = this.phonecode;
    data['nationality'] = this.nationality;
    return data;
  }
}

class Links {
  var url;
  var label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
