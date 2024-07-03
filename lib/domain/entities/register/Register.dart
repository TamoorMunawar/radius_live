import 'Role.dart';

/// id : 95
/// company_id : 1
/// name : "bilal"
/// email : "testaeddesdde@gmail.com"
/// image : "3c9d878226ceb52e085e7cfe04bb7e73.jpg"
/// country_phonecode : "93"
/// mobile : "03245154874"
/// gender : "male"
/// country_id : null
/// qr_image : "https://dashboard.radiusapp.online/users/qrcodes/bilal.svg"
/// image_url : "https://dashboard.radiusapp.online/user-uploads/avatar/3c9d878226ceb52e085e7cfe04bb7e73.jpg"
/// role : {"role_id":2,"name":"employee","display_name":"Usher","description":"Employee can see tasks and projects assigned to him."}

class Register {
  Register({
      this.id, 
      this.companyId, 
      this.name, 
      this.email, 
      this.image, 
      this.countryPhonecode, 
      this.mobile, 
      this.deviceToken,
      this.gender,
      this.countryId,
      this.qrImage, 
      this.imageUrl, 
      this.role,});

  Register.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
   // countryPhonecode = json['country_phonecode'];
    mobile = json['mobile'];
    gender = json['gender'];
    countryId = json['country_id'];
    qrImage = json['qr_image'];
    imageUrl = json['image_url'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }
  int? id;
  int? companyId;
  String? name;
  String? email;
  String? image;
  String? countryPhonecode;
  String? mobile;
  String? gender;
  dynamic countryId;
  String? qrImage;
  String? imageUrl;
  Role? role;String? deviceToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['name'] = name;
    map['device_token'] = deviceToken;
    map['email'] = email;
    map['image'] = image;
    map['country_phonecode'] = countryPhonecode;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['country_id'] = countryId;
    map['qr_image'] = qrImage;
    map['image_url'] = imageUrl;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    return map;
  }

}