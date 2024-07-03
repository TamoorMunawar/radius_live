/// id : 188
/// event_model_id : 79
/// name : "vip"
/// description : null
/// daily_male_salary : "100"
/// total_male_salary : "100"
/// daily_female_salary : "100"
/// total_female_salary : "100"
/// created_at : "2024-04-17T10:19:51.000000Z"
/// updated_at : "2024-04-17T10:19:51.000000Z"

class JobDashboard {
  JobDashboard({
      num? id, 
      var actualSeats,
      var rate,
      var planned,
      num? eventModelId,
      String? name, 
      dynamic description, 
      String? dailyMaleSalary, 
      String? totalMaleSalary, 
      String? dailyFemaleSalary, 
      String? totalFemaleSalary, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _planned = planned;
    _actualSeats = actualSeats;
    _rate = rate;
    _eventModelId = eventModelId;
    _name = name;
    _description = description;
    _dailyMaleSalary = dailyMaleSalary;
    _totalMaleSalary = totalMaleSalary;
    _dailyFemaleSalary = dailyFemaleSalary;
    _totalFemaleSalary = totalFemaleSalary;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  JobDashboard.fromJson(dynamic json) {
    _id = json['id'];
    _actualSeats = json['actual_seats'];
    _planned = json['planned_seats'];
    _rate = json['rate'];
    _eventModelId = json['event_model_id'];
    _name = json['name'];
    _description = json['description'];
    _dailyMaleSalary = json['daily_male_salary'];
    _totalMaleSalary = json['total_male_salary'];
    _dailyFemaleSalary = json['daily_female_salary'];
    _totalFemaleSalary = json['total_female_salary'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _eventModelId;
  String? _name;
  var _actualSeats;
  var _planned;
  var _rate;
  dynamic _description;
  String? _dailyMaleSalary;
  String? _totalMaleSalary;
  String? _dailyFemaleSalary;
  String? _totalFemaleSalary;
  String? _createdAt;
  String? _updatedAt;
JobDashboard copyWith({  num? id,
  num? eventModelId,
  String? name,
  var actualSeats,
  var planned,
  var rate,
  dynamic description,
  String? dailyMaleSalary,
  String? totalMaleSalary,
  String? dailyFemaleSalary,
  String? totalFemaleSalary,
  String? createdAt,
  String? updatedAt,
}) => JobDashboard(  id: id ?? _id,
  eventModelId: eventModelId ?? _eventModelId,
  name: name ?? _name,
  actualSeats: actualSeats ?? _actualSeats,
  planned: planned ?? _planned,
  rate: rate ?? _rate,
  description: description ?? _description,
  dailyMaleSalary: dailyMaleSalary ?? _dailyMaleSalary,
  totalMaleSalary: totalMaleSalary ?? _totalMaleSalary,
  dailyFemaleSalary: dailyFemaleSalary ?? _dailyFemaleSalary,
  totalFemaleSalary: totalFemaleSalary ?? _totalFemaleSalary,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get eventModelId => _eventModelId;
  String? get name => _name;
   get planned => _planned;
  get actualSeats => _actualSeats;
  get rate => _rate;

  dynamic get description => _description;
  String? get dailyMaleSalary => _dailyMaleSalary;
  String? get totalMaleSalary => _totalMaleSalary;
  String? get dailyFemaleSalary => _dailyFemaleSalary;
  String? get totalFemaleSalary => _totalFemaleSalary;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['event_model_id'] = _eventModelId;
    map['name'] = _name;
    map['actual_seats'] = _actualSeats;
    map['planned_seats'] = _planned;
    map['rate'] = _rate;
    map['description'] = _description;
    map['daily_male_salary'] = _dailyMaleSalary;
    map['total_male_salary'] = _totalMaleSalary;
    map['daily_female_salary'] = _dailyFemaleSalary;
    map['total_female_salary'] = _totalFemaleSalary;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}