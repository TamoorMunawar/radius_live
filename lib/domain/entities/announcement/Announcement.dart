/// id : 1
/// company_id : "1"
/// to : "employee"
/// heading : "Tilte - Zones"
/// description : ""
/// department_id : null
/// added_by : "1"
/// last_updated_by : "1"
/// notice_date : "17 December, 2023"

class Announcement {
  Announcement({
      this.id, 
      this.companyId, 
      this.to, 
      this.heading, 
      this.description, 
      this.departmentId, 
      this.addedBy, 
      this.lastUpdatedBy, 
      this.noticeDate,});

  Announcement.fromJson(dynamic json) {
    id = json['id'];
   // companyId = json['company_id'];
    to = json['to'];
    heading = json['heading'];
    description = json['description'];
    departmentId = json['department_id'];
  //  addedBy = json['added_by'];
   // lastUpdatedBy = json['last_updated_by'];
    noticeDate = json['notice_date'];
  }
  int? id;
  String? companyId;
  String? to;
  String? heading;
  String? description;
  dynamic departmentId;
  String? addedBy;
  String? lastUpdatedBy;
  String? noticeDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['to'] = to;
    map['heading'] = heading;
    map['description'] = description;
    map['department_id'] = departmentId;
    map['added_by'] = addedBy;
    map['last_updated_by'] = lastUpdatedBy;
    map['notice_date'] = noticeDate;
    return map;
  }

}