class KycRequestModel {
  int? id;
  Country? country;
  String? name;
  String? legalRepresentativeName;
  String? companyNumber;
  String? swiftCode;
  String? email;
  String? address;
  String? pinCode;
  String? bankAccountNumber;
  String? bankName;
  List<SellInterest>? sellInterest;

  KycRequestModel(
      {this.id,
      this.country,
      this.name,
      this.legalRepresentativeName,
      this.companyNumber,
      this.swiftCode,
      this.email,
      this.address,
      this.pinCode,
      this.bankAccountNumber,
      this.bankName,
      this.sellInterest});

  KycRequestModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    country =
        json["country"] == null ? null : Country.fromJson(json["country"]);
    name = json["name"];
    legalRepresentativeName = json["legalRepresentativeName"];
    companyNumber = json["companyNumber"];
    swiftCode = json["swiftCode"];
    email = json["email"];
    address = json["address"];
    pinCode = json["pinCode"];
    bankAccountNumber = json["bankAccountNumber"];
    bankName = json["bankName"];
    sellInterest = json["sellInterest"] == null
        ? null
        : (json["sellInterest"] as List)
            .map((e) => SellInterest.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (country != null) {
      data["country"] = country?.toJson();
    }
    data["name"] = name;
    data["legalRepresentativeName"] = legalRepresentativeName;
    data["companyNumber"] = companyNumber;
    data["swiftCode"] = swiftCode;
    data["email"] = email;
    data["address"] = address;
    data["pinCode"] = pinCode;
    data["bankAccountNumber"] = bankAccountNumber;
    data["bankName"] = bankName;
    if (sellInterest != null) {
      data["sellInterest"] = sellInterest?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class SellInterest {
  int? id;

  SellInterest({this.id});

  SellInterest.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    return data;
  }
}

class Country {
  int? id;

  Country({this.id});

  Country.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    return data;
  }
}
