import 'package:metaltrade/features/home/domain/entities/home_page_enquiry_entity.dart';

class HomePageEnquiryModel extends HomePageEnquiryEntity {
  HomePageEnquiryModel(
      {List<Content>? content,
      int? totalPages,
      int? totalElements,
      bool? last,
      int? size,
      int? number,
      int? numberOfElements,
      bool? first,
      bool? empty})
      : super(
            content: content,
            empty: empty,
            first: first,
            last: last,
            number: number,
            numberOfElements: numberOfElements,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages);

  factory HomePageEnquiryModel.fromJson(Map<String, dynamic> json) {
    return HomePageEnquiryModel(
        content: json["content"] == null
            ? null
            : (json["content"] as List)
                .map((e) => Content.fromJson(e))
                .toList(),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        size: json["size"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"]);
  }
}

class Content {
  String? lastModifiedDate;
  int? id;
  List<Item>? item;
  EnquiryCompany? enquiryCompany;
  String? enquiryType;
  String? transportationTerms;
  String? paymentTerms;
  String? deliveryTerms;
  String? status;
  int? quoteCount;
  String? uuid;
  int? matchingEnquiries;

  Content(
      {this.id,
      this.lastModifiedDate,
      this.item,
      this.enquiryCompany,
      this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.status,
      this.quoteCount,
      this.matchingEnquiries,
      this.uuid});

  Content.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    lastModifiedDate = json["lastModifiedDate"];
    item = json["item"] == null
        ? null
        : (json["item"] as List).map((e) => Item.fromJson(e)).toList();
    enquiryCompany = json["enquiryCompany"] == null
        ? null
        : EnquiryCompany.fromJson(json["enquiryCompany"]);
    enquiryType = json["enquiryType"];
    transportationTerms = json["transportationTerms"];
    paymentTerms = json["paymentTerms"];
    deliveryTerms = json["deliveryTerms"];
    status = json["status"];
    quoteCount = json["quoteCount"];
    uuid = json["uuid"];
    matchingEnquiries = json['matchingEnquiries'];
  }
}

class EnquiryCompany {
  String? lastModifiedDate;
  int? id;
  String? name;
  String? address;
  String? pinCode;
  String? email;
  dynamic phone;
  String? status;
  String? locale;
  Country? country;

  EnquiryCompany(
      {this.lastModifiedDate,
      this.id,
      this.name,
      this.address,
      this.pinCode,
      this.email,
      this.phone,
      this.status,
      this.locale,
      this.country});

  EnquiryCompany.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    name = json["name"];
    address = json["address"];
    pinCode = json["pinCode"];
    email = json["email"];
    phone = json["phone"];
    status = json["status"];
    locale = json["locale"];
    country =
        json["country"] == null ? null : Country.fromJson(json["country"]);
  }
}

class Item {
  String? lastModifiedDate;
  int? id;
  Sku? sku;
  int? quantity;
  String? quantityUnit;
  double? price;
  String? remarks;

  Item(
      {this.id,
      this.sku,
      this.quantity,
      this.quantityUnit,
      this.price,
      this.remarks,
      this.lastModifiedDate});

  Item.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    sku = json["sku"] == null ? null : Sku.fromJson(json["sku"]);
    quantity = json["quantity"];
    quantityUnit = json["quantityUnit"];
    price = json["price"];
    remarks = json["remarks"];
  }
}

class Sku {
  int? id;
  String? title;

  Sku({this.id, this.title});

  Sku.fromJson(Map<String, dynamic> json) {
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
