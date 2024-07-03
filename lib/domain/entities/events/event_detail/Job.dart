/// id : 56
/// event_model_id : 24
/// name : "testing job"
/// description : null
/// daily_male_salary : "22"
/// total_male_salary : "22"
/// daily_female_salary : "33"
/// total_female_salary : "33"
/// created_at : "2024-02-01T18:39:23.000000Z"
/// updated_at : "2024-02-01T18:39:23.000000Z"
/// get_zone : null

class Job {
  Job({
      this.id, 
      this.eventModelId, 
      this.name, 
      this.description, 
      this.dailyMaleSalary, 
      this.totalMaleSalary, 
      this.dailyFemaleSalary, 
      this.totalFemaleSalary, 
      this.createdAt, 
      this.updatedAt, 
      this.getZone,});

  Job.fromJson(dynamic json) {
    id = json['id'];
    eventModelId = json['event_model_id'];
    name = json['name'];
    description = json['description'];
    dailyMaleSalary = json['daily_male_salary'];
    totalMaleSalary = json['total_male_salary'];
    dailyFemaleSalary = json['daily_female_salary'];
    totalFemaleSalary = json['total_female_salary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getZone = json['get_zone'];
  }
  int? id;
  int? eventModelId;
  String? name;
  dynamic description;
  String? dailyMaleSalary;
  String? totalMaleSalary;
  String? dailyFemaleSalary;
  String? totalFemaleSalary;
  String? createdAt;
  String? updatedAt;
  dynamic getZone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_model_id'] = eventModelId;
    map['name'] = name;
    map['description'] = description;
    map['daily_male_salary'] = dailyMaleSalary;
    map['total_male_salary'] = totalMaleSalary;
    map['daily_female_salary'] = dailyFemaleSalary;
    map['total_female_salary'] = totalFemaleSalary;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['get_zone'] = getZone;
    return map;
  }

}