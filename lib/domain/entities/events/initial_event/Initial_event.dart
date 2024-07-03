import 'Zones.dart';
import 'Country.dart';

/// id : 8
/// added_by : null
/// event_name : "CR7 MEUSEUM"
/// logo : "31b0374aefe044e3da16274a4dd20c10.jpg"
/// country_id : "187"
/// city_id : "1"
/// district : "Riyadh"
/// latitude : "24.828243"
/// longitude : "67.1701853"
/// location : null
/// radius : "99"
/// start_date : "2023-12-25T00:00:00+00:00"
/// end_date : "2024-03-25T00:00:00+00:00"
/// start_time : "04:00"
/// end_time : "12:00"
/// manager_id : null
/// warehouse_manager_id : null
/// lead_time : "1"
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
/// isProjectAdmin : false
/// full_address : "1, Riyadh, SAUDI ARABIA"
/// members : []
/// zones : [{"id":45,"company_id":1,"category_name":"Vip 2","added_by":1,"last_updated_by":1,"description":null,"location":"12","male_seat":0,"female_seat":0,"seats_count":0}]
/// manager : null
/// ware_house_manager : null
/// country : {"id":187,"iso":"SA","name":"SAUDI ARABIA","nicename":"Saudi Arabia","iso3":"SAU","numcode":682,"phonecode":966,"nationality":"Saudi"}

class InitialEvent {
  InitialEvent({
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
      this.isProjectAdmin, 
      this.fullAddress, 
      this.members, 
      this.zones, 
      this.manager, 
      this.wareHouseManager, 
      this.country,});

  InitialEvent.fromJson(dynamic json) {
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
    startDate = json['start_dates'];
    endDate = json['end_dates'];
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

    if (json['zones'] != null) {
      zones = [];
      json['zones'].forEach((v) {
        zones?.add(Zones.fromJson(v));
      });
    }
    manager = json['manager'];
    wareHouseManager = json['ware_house_manager'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  int? id;
  dynamic addedBy;
  String? eventName;
  String? logo;
  String? countryId;
  String? cityId;
  String? district;
  String? latitude;
  String? longitude;
  dynamic location;
  String? radius;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  dynamic managerId;
  dynamic warehouseManagerId;
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
  bool? isProjectAdmin;
  String? fullAddress;
  List<dynamic>? members;
  List<Zones>? zones;
  dynamic manager;
  dynamic wareHouseManager;
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
    map['start_date'] = startDate;
    map['end_date'] = endDate;
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
    map['isProjectAdmin'] = isProjectAdmin;
    map['full_address'] = fullAddress;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    if (zones != null) {
      map['zones'] = zones?.map((v) => v.toJson()).toList();
    }
    map['manager'] = manager;
    map['ware_house_manager'] = wareHouseManager;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}