import 'Job.dart';
import 'GetZone.dart';

/// id : 32
/// event_model_id : 24
/// zone_id : 40
/// event_job_id : 56
/// male_main_seats : 3
/// female_main_seats : 3
/// any_gender_main_seats : null
/// male_stby_seats : 3
/// female_stby_seats : 3
/// any_gender_stby_seats : null
/// created_at : "2024-02-01T18:40:31.000000Z"
/// updated_at : "2024-02-01T18:40:31.000000Z"
/// job : {"id":56,"event_model_id":24,"name":"testing job","description":null,"daily_male_salary":"22","total_male_salary":"22","daily_female_salary":"33","total_female_salary":"33","created_at":"2024-02-01T18:39:23.000000Z","updated_at":"2024-02-01T18:39:23.000000Z","get_zone":null}
/// get_zone : {"id":40,"company_id":1,"category_name":"testing zone","added_by":1,"last_updated_by":1,"description":"sfsdfsdfsdfsvvxcvxvsfv","location":"sdfsdfs","male_seat":0,"female_seat":0,"seats_count":0}

class EventZoneAll {
  EventZoneAll({
      this.id, 
      this.eventModelId, 
      this.zoneId, 
      this.eventJobId, 
      this.maleMainSeats, 
      this.femaleMainSeats, 
      this.anyGenderMainSeats, 
      this.maleStbySeats, 
      this.femaleStbySeats, 
      this.anyGenderStbySeats, 
      this.createdAt, 
      this.updatedAt, 
      this.job, 
      this.getZone,});

  EventZoneAll.fromJson(dynamic json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    zoneId = json['zone_id'];
    eventJobId = json['event_job_id'];
    maleMainSeats = json['male_main_seats'];
    femaleMainSeats = json['female_main_seats'];
    anyGenderMainSeats = json['any_gender_main_seats'];
    maleStbySeats = json['male_stby_seats'];
    femaleStbySeats = json['female_stby_seats'];
    anyGenderStbySeats = json['any_gender_stby_seats'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    getZone = json['get_zone'] != null ? GetZone.fromJson(json['get_zone']) : null;
  }
  int? id;
  int? eventModelId;
  int? zoneId;
  int? eventJobId;
  int? maleMainSeats;
  int? femaleMainSeats;
  dynamic anyGenderMainSeats;
  int? maleStbySeats;
  int? femaleStbySeats;
  dynamic anyGenderStbySeats;
  String? createdAt;
  String? updatedAt;
  Job? job;
  GetZone? getZone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_model_id'] = eventModelId;
    map['zone_id'] = zoneId;
    map['event_job_id'] = eventJobId;
    map['male_main_seats'] = maleMainSeats;
    map['female_main_seats'] = femaleMainSeats;
    map['any_gender_main_seats'] = anyGenderMainSeats;
    map['male_stby_seats'] = maleStbySeats;
    map['female_stby_seats'] = femaleStbySeats;
    map['any_gender_stby_seats'] = anyGenderStbySeats;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (job != null) {
      map['job'] = job?.toJson();
    }
    if (getZone != null) {
      map['get_zone'] = getZone?.toJson();
    }
    return map;
  }

}