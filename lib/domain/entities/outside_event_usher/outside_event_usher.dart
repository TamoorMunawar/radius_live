/// id : 5628
/// company_id : 1
/// name : "mohammed yassin"
/// email : "mohayassin2467@gmail.com"
/// two_factor_secret : null
/// two_factor_recovery_codes : null
/// two_factor_confirmed : 0
/// two_factor_email_confirmed : 0
/// image : "29b4c2a8820720d7b2cadaa8aab72373.jpg"
/// country_phonecode : "+966"
/// mobile : "598436889"
/// gender : "male"
/// salutation : null
/// locale : "en"
/// status : "active"
/// login : "enable"
/// onesignal_player_id : null
/// last_login : "2024-05-18T18:27:39+00:00"
/// email_notifications : 1
/// country_id : null
/// dark_theme : 0
/// rtl : 0
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
/// qr_image : "https://dashboard.radiusapp.online/users/qrcodes/mohammed yassin5628.svg"
/// device_token : "cWO7aPKlgEBDpkQ5I8bA7J:APA91bGPKcYjWsnH9pwrNUixcQYQELMlj1TitNFrgvferOT6BqOl_w9i4Tr85rMRzJnpaXIy3HdPQRUyEMUJ98ARQHv8hApd7FWwwtOVi5z681oakFbGWgcd-uFN_pWMI5fqsN7qqVkq"
/// whatsapp_number : "598436889"
/// whatsapp_number_country_code : "+966"
/// latitude : "0.0"
/// longitude : "0.0"
/// image_url : "https://dashboard.radiusapp.online/user-uploads/avatar/29b4c2a8820720d7b2cadaa8aab72373.jpg"
/// mobile_with_phonecode : "++966598436889"
/// job_name : null
/// checkIn : null
/// client_details : null
/// leaves : []
/// is_out : true
/// alert_message : "Out of Event"

class OutsideEventUsher {
  OutsideEventUsher({
      this.id, 
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
      this.imageUrl, 
      this.mobileWithPhonecode, 
      this.jobName, 
      this.checkIn, 
      this.clientDetails, 
      this.leaves, 
      this.iqamaId,
      this.isOut,
      this.alertMessage,});

  OutsideEventUsher.fromJson(dynamic json) {
    print("OutsideEventUsher ${json['id']} ");
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    iqamaId = json['iqama_id'];
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
    imageUrl = json['image_url'];
    mobileWithPhonecode = json['mobile_with_phonecode'];
    jobName = json['job_name'];
    checkIn = json['checkIn'];
    clientDetails = json['client_details'];

    isOut = json['is_out'];
    alertMessage = json['alert_message'];
  }
  int? id;
  int? companyId;
  String? name;
  String? iqamaId;
  String? email;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  int? twoFactorConfirmed;
  int? twoFactorEmailConfirmed;
  String? image;
  String? countryPhonecode;
  String? mobile;
  String? gender;
  dynamic salutation;
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
  String? deviceToken;
  String? whatsappNumber;
  String? whatsappNumberCountryCode;
  String? latitude;
  String? longitude;
  String? imageUrl;
  String? mobileWithPhonecode;
  dynamic jobName;
  dynamic checkIn;
  dynamic clientDetails;
  List<dynamic>? leaves;
  bool? isOut;
  String? alertMessage;

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
    map['device_token'] = deviceToken;
    map['whatsapp_number'] = whatsappNumber;
    map['whatsapp_number_country_code'] = whatsappNumberCountryCode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['image_url'] = imageUrl;
    map['mobile_with_phonecode'] = mobileWithPhonecode;
    map['job_name'] = jobName;
    map['checkIn'] = checkIn;
    map['client_details'] = clientDetails;
    if (leaves != null) {
      map['leaves'] = leaves?.map((v) => v.toJson()).toList();
    }
    map['is_out'] = isOut;
    map['alert_message'] = alertMessage;
    return map;
  }

}