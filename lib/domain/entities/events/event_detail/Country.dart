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