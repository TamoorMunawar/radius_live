/// id : 1
/// company_id : "1"
/// team_name : "IT"
/// parent_id : null
/// added_by : null
/// last_updated_by : null
/// childs : []

class Department {
  Department({
      this.id, 
      this.companyId, 
      this.teamName, 
      this.parentId, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.childs,});

  Department.fromJson(dynamic json) {
    id = json['id'];
//    companyId = json['company_id'];
    teamName = json['team_name'];
    parentId = json['parent_id'];
    addedBy = json['added_by'];
    lastUpdatedBy = json['last_updated_by'];
    /*if (json['childs'] != null) {
      childs = [];
      json['childs'].forEach((v) {
        childs?.add(Dynamic.fromJson(v));
      });
    }*/
  }
  int? id;
  String? companyId;
  String? teamName;
  dynamic parentId;
  dynamic addedBy;
  dynamic lastUpdatedBy;
  List<dynamic>? childs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['team_name'] = teamName;
    map['parent_id'] = parentId;
    map['added_by'] = addedBy;
    map['last_updated_by'] = lastUpdatedBy;
    if (childs != null) {
      map['childs'] = childs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}