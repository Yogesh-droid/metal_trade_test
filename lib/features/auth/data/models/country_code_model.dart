class CountryCodeModel {
  String? name;
  String? code;
  String? dialCode;
  String? emoji;

  CountryCodeModel({this.name, this.code, this.dialCode, this.emoji});

  CountryCodeModel.fromJson(Map<String, dynamic> map) {
    name = map["name"];
    code = map['code'];
    dialCode = map['dialCode'];
    emoji = map["emoji"];
  }
}
