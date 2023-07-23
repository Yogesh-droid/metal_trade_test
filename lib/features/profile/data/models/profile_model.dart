import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    String? lastModifiedDate,
    int? id,
    String? mobileNumber,
    Company? company,
    String? status,
  }) : super(
            company: company,
            id: id,
            lastModifiedDate: lastModifiedDate,
            mobileNumber: mobileNumber,
            status: status);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        lastModifiedDate: json["lastModifiedDate"],
        id: json["id"],
        mobileNumber: json["mobileNumber"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        status: json["status"]);
  }
}

class Company {
  String? lastModifiedDate;
  int? id;
  String? name;
  String? legalRepresentativeName;
  String? companyNumber;
  String? address;
  Country? country;
  String? pinCode;
  String? bankAccountNumber;
  String? bankName;
  String? swiftCode;
  String? email;
  dynamic phone;
  String? status;
  List<SellInterest>? sellInterest;
  String? locale;
  ProfileCompletion? profileCompletion;

  Company(
      {this.lastModifiedDate,
      this.id,
      this.name,
      this.legalRepresentativeName,
      this.companyNumber,
      this.address,
      this.country,
      this.pinCode,
      this.bankAccountNumber,
      this.bankName,
      this.swiftCode,
      this.email,
      this.phone,
      this.status,
      this.sellInterest,
      this.locale,
      this.profileCompletion});

  Company.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    name = json["name"];
    legalRepresentativeName = json["legalRepresentativeName"];
    companyNumber = json["companyNumber"];
    address = json["address"];
    country =
        json["country"] == null ? null : Country.fromJson(json["country"]);
    pinCode = json["pinCode"];
    bankAccountNumber = json["bankAccountNumber"];
    bankName = json["bankName"];
    swiftCode = json["swiftCode"];
    email = json["email"];
    phone = json["phone"];
    status = json["status"];
    sellInterest = json["sellInterest"] == null
        ? null
        : (json["sellInterest"] as List)
            .map((e) => SellInterest.fromJson(e))
            .toList();
    locale = json["locale"];
    profileCompletion = json['profileCompletion'] != null
        ? ProfileCompletion.fromJson(json['profileCompletion'])
        : null;
  }
}

class SellInterest {
  int? id;
  String? title;

  SellInterest({this.id, this.title});

  SellInterest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}

class ProfileCompletion {
  int? completion;
  String? next;

  ProfileCompletion({this.completion, this.next});

  ProfileCompletion.fromJson(Map<String, dynamic> json) {
    completion = json["completion"];
    next = json["next"];
  }
}
