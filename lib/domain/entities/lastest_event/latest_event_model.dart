/// id : 80
/// added_by : null
/// event_name : "الوحدة Xالحزم"
/// logo : null
/// country_id : "187"
/// city_id : "Mecca"
/// district : null
/// latitude : "21.4855089"
/// longitude : "39.9738742"
/// location : null
/// radius : "30000"
/// start_date : "2024-04-25T00:00:00+00:00"
/// end_date : "2024-04-25T00:00:00+00:00"
/// start_time : "15:01"
/// end_time : "23:50"
/// manager_id : "4547"
/// warehouse_manager_id : "4547"
/// lead_time : null
/// lead_time_unit : null
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
/// full_address : "Mecca, , SAUDI ARABIA"
/// start_dates : "25-Apr-2024"
/// end_dates : "25-Apr-2024"
/// members : []
/// country : {"id":187,"iso":"SA","name":"SAUDI ARABIA","nicename":"Saudi Arabia","iso3":"SAU","numcode":682,"phonecode":966,"nationality":"Saudi"}

class LatestEventModel {
  LatestEventModel({
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
      this.startDates, 
      this.endDates, 
      this.members, 
      this.country,});

  LatestEventModel.fromJson(dynamic json) {
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
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? managerId;
  String? warehouseManagerId;
  dynamic leadTime;
  dynamic leadTimeUnit;
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
  String? startDates;
  String? endDates;
  List<dynamic>? members;
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
    map['start_dates'] = startDates;
    map['end_dates'] = endDates;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}

/// id : 187
/// iso : "SA"
/// name : "SAUDI ARABIA"
/// nicename : "Saudi Arabia"
/// iso3 : "SAU"
/// numcode : 682
/// phonecode : 966
/// nationality : "Saudi"

class Country {
  Country({
      this.id, 
      this.iso, 
      this.name, 
      this.nicename, 
      this.iso3, 
      this.numcode, 
      this.phonecode, 
      this.nationality,});

  Country.fromJson(dynamic json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
    nationality = json['nationality'];
  }
  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  int? numcode;
  int? phonecode;
  String? nationality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['iso'] = iso;
    map['name'] = name;
    map['nicename'] = nicename;
    map['iso3'] = iso3;
    map['numcode'] = numcode;
    map['phonecode'] = phonecode;
    map['nationality'] = nationality;
    return map;
  }

}