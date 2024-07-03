/// id : 686
/// company_id : 1
/// category_name : "demo 1"
/// added_by : 1
/// last_updated_by : 1
/// description : "11"
/// location : "1"
/// male_seat : 0
/// female_seat : 0
/// planned_seats : 22
/// actual_seats : 0
/// remaining_seats : 22
/// rate : "0.0%"
/// seats_count : 0
/// suppervisor : "1 Supervisor"

class ZoneDashboard {
  ZoneDashboard({
      this.id, 
      this.companyId, 
      this.categoryName, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.description, 
      this.location, 
      this.maleSeat, 
      this.femaleSeat, 
      this.plannedSeats, 
      this.actualSeats, 
      this.remainingSeats, 
      this.rate, 
      this.seatsCount, 
      this.suppervisor,});

  ZoneDashboard.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    categoryName = json['category_name'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    description = json['description'];
    location = json['location'];
    maleSeat = json['male_seat'];
    femaleSeat = json['female_seat'];
    plannedSeats = json['planned_seats'];
    actualSeats = json['actual_seats'];
    remainingSeats = json['remaining_seats'];
    rate = json['rate'];
    seatsCount = json['seats_count'];
    suppervisor = json['suppervisor'];
  }
  int? id;
  int? companyId;
  String? categoryName;
  int? addedBy;
  int? lastUpdatedBy;
  String? description;
  String? location;
  int? maleSeat;
  int? femaleSeat;
  int? plannedSeats;
  int? actualSeats;
  int? remainingSeats;
  String? rate;
  int? seatsCount;
  String? suppervisor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['category_name'] = categoryName;
    map['added_by'] = addedBy;
    map['last_updated_by'] = lastUpdatedBy;
    map['description'] = description;
    map['location'] = location;
    map['male_seat'] = maleSeat;
    map['female_seat'] = femaleSeat;
    map['planned_seats'] = plannedSeats;
    map['actual_seats'] = actualSeats;
    map['remaining_seats'] = remainingSeats;
    map['rate'] = rate;
    map['seats_count'] = seatsCount;
    map['suppervisor'] = suppervisor;
    return map;
  }

}