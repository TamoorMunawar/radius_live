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

class Login {
  Login(
      {this.id,
      this.companyId,
      this.iqamaId,
      this.name,
      this.email,
      this.image,
      this.countryPhonecode,
      this.mobile,
      this.gender,
      this.countryId,
      this.qrImage,
      this.deviceToken,
      this.imageUrl,
      this.whatsappNumber,
      this.role,
      this.isVerified});

  Login.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    image = json['image'];
    countryPhonecode = json['country_phonecode'].toString() ?? "";
    mobile = json['mobile'];
    gender = json['gender'];
    iqamaId = json['iqama_id'];
    countryId = json['country_id'];
    qrImage = json['qr_image'];
    imageUrl = json['image_url'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    isVerified = json['is_verified'];
  }
  int? id;
  int? companyId;
  String? name;
  String? iqamaId;
  String? email;
  String? image;
  String? whatsappNumber;
  String? countryPhonecode;
  String? mobile;
  String? gender;
  dynamic countryId;
  String? qrImage;
  String? imageUrl;
  String? deviceToken;
  Role? role;
  bool? isVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_id'] = companyId;
    map['name'] = name;
    map['email'] = email;
    //map['device_token'] = deviceToken;
    map['image'] = image;
    map['country_phonecode'] = countryPhonecode;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['country_id'] = countryId;
    map['qr_image'] = qrImage;
    map['image_url'] = imageUrl;
    map['is_verified'] = isVerified;

    if (role != null) {
      map['role'] = role?.toJson();
    }
    return map;
  }
}
