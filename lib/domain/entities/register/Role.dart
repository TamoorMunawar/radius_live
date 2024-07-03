/// role_id : 2
/// name : "employee"
/// display_name : "Usher"
/// description : "Employee can see tasks and projects assigned to him."

class Role {
  Role({
      this.roleId, 
      this.name, 
      this.displayName, 
      this.description,});

  Role.fromJson(dynamic json) {
    roleId = json['role_id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
  }
  int? roleId;
  String? name;
  String? displayName;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role_id'] = roleId;
    map['name'] = name;
    map['display_name'] = displayName;
    map['description'] = description;
    return map;
  }

}