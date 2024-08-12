/// name : "aa"
/// email : "emaq@gmail.com"
/// password : 12345678
/// gender : "male"
/// country_phonecode : "+92"
/// mobile : "3212444600"
/// country_id : "2"
/// date_of_birth : "16-05-1998"
/// about_me : "sdfsdfsdf"
/// image : "3212444600"

class RegisterPayload {
  RegisterPayload({
    this.name,
    this.iqamaId,
    this.email,
    this.password,
    this.gender,
    this.countryPhonecode,
    this.mobile,
    this.whatsappCountryCode,
    this.age,
    this.countryId,
    this.iqamaExpiry,
    this.dateOfBirth,
    this.aboutMe,
    this.deviceToken,
    this.deviceName,
    this.deviceId,
    this.whatsappNumber,
    this.city,
    this.image,
    this.departmentcode,
  });

  RegisterPayload.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    countryPhonecode = json['country_phonecode'];
    mobile = json['mobile'];
    countryId = json['country_id'];
    dateOfBirth = json['date_of_birth'];
    aboutMe = json['about_me'];
    image = json['image'];
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    departmentcode = json['department_code'];
  }
  String? iqamaId;
  String? name;
  String? email;
  String? whatsappCountryCode;
  String? password;
  String? gender;
  String? countryPhonecode;
  String? mobile;
  String? countryId;
  String? dateOfBirth;
  String? whatsappNumber;
  String? age;
  String? aboutMe;
  String? iqamaExpiry;
  String? image;
  String? deviceToken;
  String? deviceName;
  String? deviceId;
  String? city;
  String? departmentcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['gender'] = gender;
    map['age'] = age;
    map['date_of_birth'] = dateOfBirth;
    map['city'] = city;
    map['iqama_id'] = iqamaId;
    map['iqama_expiry'] = iqamaExpiry;
    map['whatsapp_number_country_code'] = whatsappCountryCode;
    map['WhatsApp_number'] = whatsappNumber;
    map['country_phonecode'] = countryPhonecode;
    map['mobile'] = mobile;
    map['country_id'] = countryId;
    map['device_token'] = deviceToken;
    map['device_token'] = deviceId;
    map['device_token'] = deviceName;
    map['about_me'] = aboutMe;
    map['image'] = image;
    map['department_code']= departmentcode;
    return map;
  }
}
