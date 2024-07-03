/// id : 19
/// company_id : 1
/// category_name : "VIP area"
/// added_by : 1
/// last_updated_by : 1
/// description : null
/// location : null
/// male_seat : 0
/// female_seat : 0
/// seats_count : 1

class Zone {
  Zone({
      this.id, 
      this.companyId, 
      this.categoryName, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.description, 
      this.location, 
      this.suppervisor,
      this.maleSeat,
      this.femaleSeat, 
      this.invitationCount,
  //    this.femaleSeat,
      this.seatsCount,});

  Zone.fromJson(dynamic json) {
    invitationCount = json['invitations_count']??0;
    id = json['id'];
    companyId = json['company_id'];
    categoryName = json['category_name'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    description = json['description'];
    location = json['location'];
    suppervisor = json['suppervisor'];
    maleSeat = json['male_seat'];
    femaleSeat = json['female_seat'];
    seatsCount = json['seats_count'];
  }
  int? id;
  int? companyId;
  String? categoryName;
  int? addedBy;
  int? lastUpdatedBy;
  dynamic description;
  dynamic location;
  int? maleSeat;
  String? suppervisor;
  int? femaleSeat;
  int? invitationCount;
  int? seatsCount;

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
    map['seats_count'] = seatsCount;
    return map;
  }

}