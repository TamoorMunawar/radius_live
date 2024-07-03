/// code : "SK"
/// label : "Slovakia"
/// phone : "421"
/// phoneLength : 9

class CountryCodeModel {
  CountryCodeModel({
      this.code, 
      this.label, 
      this.phone, 
      this.phoneLength,});

  CountryCodeModel.fromJson(dynamic json) {
    code = json['code'];
    label = json['label'];
    phone = json['phone'];
    phoneLength = json['phoneLength'];
  }
  String? code;
  String? label;
  String? phone;
  int? phoneLength;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['label'] = label;
    map['phone'] = phone;
    map['phoneLength'] = phoneLength;
    return map;
  }

}