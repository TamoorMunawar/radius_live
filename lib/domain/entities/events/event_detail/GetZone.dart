/// id : 40
/// company_id : 1
/// category_name : "testing zone"
/// added_by : 1
/// last_updated_by : 1
/// description : "sfsdfsdfsdfsvvxcvxvsfv"
/// location : "sdfsdfs"
/// male_seat : 0
/// female_seat : 0
/// seats_count : 0

class GetZone {
  GetZone({
      this.id, 
      this.companyId, 
      this.categoryName, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.description, 
      this.location, 
      this.maleSeat, 
      this.femaleSeat, 
      this.seatsCount,});

  GetZone.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    categoryName = json['category_name'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    description = json['description'];
    location = json['location'];
    maleSeat = json['male_seat'];
    femaleSeat = json['female_seat'];
    seatsCount = json['seats_count'];
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