import 'package:flutter/material.dart';

import 'Event_zone_all.dart';
import 'Manager.dart';
import 'WareHouseManager.dart';
import 'Country.dart';

/// id : 24
/// added_by : null
/// event_name : "testing event"
/// logo : null
/// country_id : "187"
/// city_id : "5"
/// district : null
/// latitude : "24.882491"
/// longitude : "67.0659372"
/// location : null
/// radius : "3"
/// start_date : "2024-02-01T00:00:00+00:00"
/// end_date : "2024-02-13T00:00:00+00:00"
/// start_time : "14:22"
/// end_time : "03:33"
/// manager_id : "104"
/// warehouse_manager_id : "104"
/// lead_time : "2"
/// lead_time_unit : "hour"
/// project_summary : ""
/// terms_condition : null
/// terms_condition_arabic : null
/// hidden_fields : null
/// status : "published"
/// completion_percent : null
/// currency_id : "1"
/// budget : null
/// dayoff : "null"
/// deleted_at : null
/// format_start_date : "February 01, 2024"
/// format_end_date : "February 13, 2024"
/// isProjectAdmin : false
/// full_address : "5, , SAUDI ARABIA"
/// members : []
/// event_zones_all : [{"id":32,"event_model_id":24,"zone_id":40,"event_job_id":56,"male_main_seats":3,"female_main_seats":3,"any_gender_main_seats":null,"male_stby_seats":3,"female_stby_seats":3,"any_gender_stby_seats":null,"created_at":"2024-02-01T18:40:31.000000Z","updated_at":"2024-02-01T18:40:31.000000Z","job":{"id":56,"event_model_id":24,"name":"testing job","description":null,"daily_male_salary":"22","total_male_salary":"22","daily_female_salary":"33","total_female_salary":"33","created_at":"2024-02-01T18:39:23.000000Z","updated_at":"2024-02-01T18:39:23.000000Z","get_zone":null},"get_zone":{"id":40,"company_id":1,"category_name":"testing zone","added_by":1,"last_updated_by":1,"description":"sfsdfsdfsdfsvvxcvxvsfv","location":"sdfsdfs","male_seat":0,"female_seat":0,"seats_count":0}},{"id":33,"event_model_id":24,"zone_id":41,"event_job_id":56,"male_main_seats":656565,"female_main_seats":65656565,"any_gender_main_seats":null,"male_stby_seats":6565656,"female_stby_seats":67656,"any_gender_stby_seats":null,"created_at":"2024-02-01T19:23:20.000000Z","updated_at":"2024-02-01T19:23:20.000000Z","job":{"id":56,"event_model_id":24,"name":"testing job","description":null,"daily_male_salary":"22","total_male_salary":"22","daily_female_salary":"33","total_female_salary":"33","created_at":"2024-02-01T18:39:23.000000Z","updated_at":"2024-02-01T18:39:23.000000Z","get_zone":null},"get_zone":{"id":41,"company_id":1,"category_name":"bbdbs","added_by":104,"last_updated_by":104,"description":"Bdndjdj","location":"Hdhdhdhdxh","male_seat":0,"female_seat":0,"seats_count":0}},{"id":34,"event_model_id":24,"zone_id":43,"event_job_id":56,"male_main_seats":23,"female_main_seats":23,"any_gender_main_seats":null,"male_stby_seats":23,"female_stby_seats":23,"any_gender_stby_seats":null,"created_at":"2024-02-01T20:36:55.000000Z","updated_at":"2024-02-01T20:36:55.000000Z","job":{"id":56,"event_model_id":24,"name":"testing job","description":null,"daily_male_salary":"22","total_male_salary":"22","daily_female_salary":"33","total_female_salary":"33","created_at":"2024-02-01T18:39:23.000000Z","updated_at":"2024-02-01T18:39:23.000000Z","get_zone":null},"get_zone":{"id":43,"company_id":1,"category_name":"zone web","added_by":1,"last_updated_by":1,"description":"asda amd a dasd","location":"asdasdasd","male_seat":0,"female_seat":0,"seats_count":0}},{"id":35,"event_model_id":24,"zone_id":44,"event_job_id":56,"male_main_seats":656565,"female_main_seats":656565,"any_gender_main_seats":null,"male_stby_seats":656556,"female_stby_seats":64656,"any_gender_stby_seats":null,"created_at":"2024-02-01T20:39:35.000000Z","updated_at":"2024-02-01T20:39:35.000000Z","job":{"id":56,"event_model_id":24,"name":"testing job","description":null,"daily_male_salary":"22","total_male_salary":"22","daily_female_salary":"33","total_female_salary":"33","created_at":"2024-02-01T18:39:23.000000Z","updated_at":"2024-02-01T18:39:23.000000Z","get_zone":null},"get_zone":{"id":44,"company_id":1,"category_name":"zone mobile","added_by":104,"last_updated_by":104,"description":"Hdhdhddh","location":"Bxhdhdh","male_seat":0,"female_seat":0,"seats_count":0}}]
/// manager : {"name":"Ali123","email":"ali@gmail.com","id":104,"image_url":"https://www.gravatar.com/avatar/d4384c2e7aab2c22eb805c0f48852f23.png?s=200&d=mp","modules":["projects","messages","tasks","timelogs","notices","settings"],"mobile_with_phonecode":"--","client_details":null,"employee_detail":{"id":156,"company_id":1,"user_id":104,"employee_id":"144","address":null,"hourly_rate":null,"slack_username":null,"department_id":3,"designation_id":4,"joining_date":"2024-01-18T00:00:00+00:00","last_date":null,"added_by":1,"last_updated_by":1,"attendance_reminder":null,"date_of_birth":null,"calendar_view":"task,events,holiday,tickets,leaves","about_me":null,"reporting_to":null,"contract_end_date":null,"internship_end_date":null,"employment_type":null,"marriage_anniversary_date":null,"marital_status":"unmarried","notice_period_end_date":null,"notice_period_start_date":null,"probation_end_date":null,"iqama_expiry":null,"city":"","upcoming_birthday":null,"designation":{"id":4,"company_id":1,"name":"Supervisor","parent_id":null,"added_by":null,"last_updated_by":null},"company":{"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":1,"timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":1,"google_map_key":null,"task_self":"yes","rounded_theme":1,"logo_background_color":"#000000","header_color":"#000000","before_days":0,"after_days":0,"on_deadline":"yes","default_task_status":1,"dashboard_clock":0,"ticket_form_google_captcha":0,"lead_form_google_captcha":0,"taskboard_length":10,"datatable_row_limit":10,"allow_client_signup":0,"admin_client_signup_approval":0,"google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":0,"show_new_webhook_alert":0,"pm_type":null,"pm_last_four":null,"employee_can_export_data":0,"logo_url":"https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png","login_background_url":"https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"},"department":{"id":3,"company_id":1,"team_name":"CR7","parent_id":null,"added_by":null,"last_updated_by":null}},"leaves":[]}
/// ware_house_manager : {"name":"Ali123","email":"ali@gmail.com","id":104,"image_url":"https://www.gravatar.com/avatar/d4384c2e7aab2c22eb805c0f48852f23.png?s=200&d=mp","modules":["projects","messages","tasks","timelogs","notices","settings"],"mobile_with_phonecode":"--","client_details":null,"employee_detail":{"id":156,"company_id":1,"user_id":104,"employee_id":"144","address":null,"hourly_rate":null,"slack_username":null,"department_id":3,"designation_id":4,"joining_date":"2024-01-18T00:00:00+00:00","last_date":null,"added_by":1,"last_updated_by":1,"attendance_reminder":null,"date_of_birth":null,"calendar_view":"task,events,holiday,tickets,leaves","about_me":null,"reporting_to":null,"contract_end_date":null,"internship_end_date":null,"employment_type":null,"marriage_anniversary_date":null,"marital_status":"unmarried","notice_period_end_date":null,"notice_period_start_date":null,"probation_end_date":null,"iqama_expiry":null,"city":"","upcoming_birthday":null,"designation":{"id":4,"company_id":1,"name":"Supervisor","parent_id":null,"added_by":null,"last_updated_by":null},"company":{"id":1,"company_name":"Radius","app_name":"Radius","company_email":"radius@email.com","company_phone":"1234567891","logo":"24d5a8e397be700c63fb55d415b3a086.png","light_logo":"003cf449dade46889872e9ff40339106.png","favicon":"7bc113efe84bf23cae8dc30c0e5ee143.png","auth_theme":"light","auth_theme_text":"light","sidebar_logo_style":"square","login_background":"9c3b77ae68f0b1e014ac25b60dd7b1f9.png","address":"Your Company address here","website":null,"currency_id":1,"timezone":"Asia/Karachi","date_format":"d-m-Y","date_picker_format":"dd-mm-yyyy","year_starts_from":"1","moment_format":"DD-MM-YYYY","time_format":"h:i a","locale":"en","latitude":"26.91243360","longitude":"75.78727090","leaves_start_from":"joining_date","active_theme":"default","status":"active","last_updated_by":1,"google_map_key":null,"task_self":"yes","rounded_theme":1,"logo_background_color":"#000000","header_color":"#000000","before_days":0,"after_days":0,"on_deadline":"yes","default_task_status":1,"dashboard_clock":0,"ticket_form_google_captcha":0,"lead_form_google_captcha":0,"taskboard_length":10,"datatable_row_limit":10,"allow_client_signup":0,"admin_client_signup_approval":0,"google_calendar_status":"inactive","google_client_id":null,"google_client_secret":null,"google_calendar_verification_status":"non_verified","google_id":null,"name":null,"token":null,"hash":"6b3e630e4ca096c89c90440492ce808c","last_login":null,"rtl":0,"show_new_webhook_alert":0,"pm_type":null,"pm_last_four":null,"employee_can_export_data":0,"logo_url":"https://dashboard.radiusapp.online/user-uploads/app-logo/003cf449dade46889872e9ff40339106.png","login_background_url":"https://dashboard.radiusapp.online/user-uploads/login-background/9c3b77ae68f0b1e014ac25b60dd7b1f9.png","moment_date_format":"DD-MM-YYYY","favicon_url":"https://dashboard.radiusapp.online/user-uploads/favicon/7bc113efe84bf23cae8dc30c0e5ee143.png"},"department":{"id":3,"company_id":1,"team_name":"CR7","parent_id":null,"added_by":null,"last_updated_by":null}},"leaves":[]}
/// country : {"id":187,"iso":"SA","name":"SAUDI ARABIA","nicename":"Saudi Arabia","iso3":"SAU","numcode":682,"phonecode":966,"nationality":"Saudi"}

class EventDetail {
  EventDetail({
    this.id,
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
    this.formatStartDate,
    this.formatEndDate,
    this.isProjectAdmin,
    this.fullAddress,
    this.members,
    this.eventZonesAll,
    this.manager,
    this.wareHouseManager,
    this.country,
  });

  EventDetail.fromJson(dynamic json) {
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
    startDate = json['start_date'] == null ? null : DateTime.parse(json['start_date']);
    endDate = json['end_date'] == null ? null : DateTime.parse(json['end_date']);

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
    formatStartDate = json['format_start_date'];
    formatEndDate = json['format_end_date'];
    isProjectAdmin = json['isProjectAdmin'];
    fullAddress = json['full_address'];

    if (json['event_zones_all'] != null) {
      eventZonesAll = [];
      json['event_zones_all'].forEach((v) {
        eventZonesAll?.add(EventZoneAll.fromJson(v));
      });
    }
    manager = json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    wareHouseManager =
        json['ware_house_manager'] != null ? WareHouseManager.fromJson(json['ware_house_manager']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  int? id;
  dynamic addedBy;
  String? eventName;
  dynamic logo;
  String? countryId;
  String? cityId;
  dynamic district;
  String? latitude;
  String? longitude;
  dynamic location;
  String? radius;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? managerId;
  String? warehouseManagerId;
  String? leadTime;
  String? leadTimeUnit;
  String? projectSummary;
  dynamic termsCondition;
  dynamic termsConditionArabic;
  dynamic hiddenFields;
  String? status;
  dynamic completionPercent;
  String? currencyId;
  dynamic budget;
  String? dayoff;
  dynamic deletedAt;
  String? formatStartDate;
  String? formatEndDate;
  bool? isProjectAdmin;
  String? fullAddress;
  List<dynamic>? members;
  List<EventZoneAll>? eventZonesAll;
  Manager? manager;
  WareHouseManager? wareHouseManager;
  Country? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['added_by'] = addedBy;
    map['event_name'] = eventName;
    map['logo'] = logo;
    map['country_id'] = countryId;
    map['city_id'] = cityId;
    map['district'] = district;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['location'] = location;
    map['radius'] = radius;
    map['start_date'] = startDate!.toIso8601String();
    map['end_date'] = endDate!.toIso8601String();
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['manager_id'] = managerId;
    map['warehouse_manager_id'] = warehouseManagerId;
    map['lead_time'] = leadTime;
    map['lead_time_unit'] = leadTimeUnit;
    map['project_summary'] = projectSummary;
    map['terms_condition'] = termsCondition;
    map['terms_condition_arabic'] = termsConditionArabic;
    map['hidden_fields'] = hiddenFields;
    map['status'] = status;
    map['completion_percent'] = completionPercent;
    map['currency_id'] = currencyId;
    map['budget'] = budget;
    map['dayoff'] = dayoff;
    map['deleted_at'] = deletedAt;
    map['format_start_date'] = formatStartDate;
    map['format_end_date'] = formatEndDate;
    map['isProjectAdmin'] = isProjectAdmin;
    map['full_address'] = fullAddress;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    if (eventZonesAll != null) {
      map['event_zones_all'] = eventZonesAll?.map((v) => v.toJson()).toList();
    }
    if (manager != null) {
      map['manager'] = manager?.toJson();
    }
    if (wareHouseManager != null) {
      map['ware_house_manager'] = wareHouseManager?.toJson();
    }
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }
}
