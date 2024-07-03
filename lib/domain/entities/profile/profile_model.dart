/// id : 3898
/// company_id : 1
/// name : "00 Murad"
/// email : "murad@epic-sa.com"
/// two_factor_secret : null
/// two_factor_recovery_codes : null
/// two_factor_confirmed : 0
/// two_factor_email_confirmed : 0
/// image : null
/// country_phonecode : 966
/// mobile : "+96655788843"
/// gender : "male"
/// salutation : null
/// locale : "en"
/// status : "active"
/// login : "enable"
/// onesignal_player_id : null
/// last_login : "2024-04-21T12:02:59+00:00"
/// email_notifications : 1
/// country_id : null
/// dark_theme : 1
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
/// qr_image : "https://dashboard.radiusapp.online/users/qrcodes/00 Murad3898.svg"
/// device_token : "ezmcxQDCR7GI8PEOhWrORD:APA91bHq-7BKGHCbLxRO9TaqMMpD-IzHqtbwW5GLmj-6vrn448hMwsN0ljxyxGH8jKWpI9MBevmD-lrtEr8y5YMECbGCzHPz9HHnuBA_0woma_hUfHK_vCNOTmHTQfhLMqCKxb5a0Ol0"
/// whatsapp_number : "+96655788843"
/// image_url : "https://www.gravatar.com/avatar/356c2265ea143b5789322caef5d5e4e1.png?s=200&d=mp"

class ProfileModel {
  ProfileModel({
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
    this.iqamaId,
    this.customisedPermissions,
    this.stripeId,
    this.pmType,
    this.pmLastFour,
    this.trialEndsAt,
    this.qrImage,
    this.deviceToken,
    this.deviceId,
    this.deviceName,
    this.whatsappNumber,
    this.imageUrl,
  });

  ProfileModel.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    email = json['email'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmed = json['two_factor_confirmed'];
    twoFactorEmailConfirmed = json['two_factor_email_confirmed'];
    image = json['image'];
    countryPhonecode = json['country_phonecode'].toString() ?? "";
    mobile = json['mobile'];
    gender = json['gender'];
    salutation = json['salutation'];
    locale = json['locale'];
    status = json['status'];
    login = json['login'];
    iqamaId = json['iqama_id'];
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
    whatsappCountryCode = json['whatsapp_number_country_code'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
    qrImage = json['qr_image'];
    deviceToken = json['device_token'];
    deviceToken = json['device_id'];
    deviceToken = json['device_name'];
    whatsappNumber = json['whatsapp_number'];
    imageUrl = json['image_url'];
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
  dynamic image;
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
  String? deviceId;
  String? deviceName;
  String? whatsappCountryCode;
  String? whatsappNumber;
  String? imageUrl;

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
    map['device_id'] = deviceId;
    map['device_name'] = deviceName;
    map['whatsapp_number'] = whatsappNumber;
    map['image_url'] = imageUrl;
    return map;
  }
}
