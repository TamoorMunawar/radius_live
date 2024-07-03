/// name : "Ahsan Zahid"
/// id : 1

class ScanQrCodePayload {
  ScanQrCodePayload({
      this.name, 
      this.type,
      this.id,});

  ScanQrCodePayload.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
  }
  String? name;
  String? type;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
  //  map['type'] = type;
    return map;
  }

}
class ScanQrCodeUsherInvitePayload {
  ScanQrCodeUsherInvitePayload({
    this.name,

    this.id,});

  ScanQrCodeUsherInvitePayload.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
  }
  String? name;
  String? type;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;

    return map;
  }

}