/// id : 4
/// company_id : 1
/// name : "Supervisor"
/// parent_id : null
/// added_by : null
/// last_updated_by : null

class Designation {
  Designation({
      this.id, 
      this.companyId, 
      this.name, 
      this.parentId, 
      this.addedBy, 
      this.lastUpdatedBy,});

  Designation.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    parentId = json['parent_id'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
  }
  int? id;
  int? companyId;
  String? name;
  dynamic parentId;
  dynamic addedBy;
  dynamic lastUpdatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['name'] = name;
    map['parent_id'] = parentId;
    map['added_by'] = addedBy;
    map['last_updated_by'] = lastUpdatedBy;
    return map;
  }

}