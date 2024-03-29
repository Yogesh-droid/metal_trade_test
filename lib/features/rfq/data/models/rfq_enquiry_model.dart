import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';

import '../../../quotes/data/models/quote_res_model.dart';

class RfqEnquiryModel extends RfqEntity {
  RfqEnquiryModel(
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

  factory RfqEnquiryModel.fromJson(Map<String, dynamic> json) {
    return RfqEnquiryModel(
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
  EnquiryCompany? quoteCompany;
  String? enquiryType;
  String? transportationTermsDisplay;
  String? transportationTerms;
  String? paymentTermsDisplay;
  String? paymentTerms;
  String? status;
  String? otherTerms;
  int? quoteCount;
  String? uuid;
  int? matchingEnquiries;
  String? otherAttachmentsUrl;
  Enquiry? enquiry;
  String? otherAttachmentsName;

  Content(
      {this.id,
      this.lastModifiedDate,
      this.item,
      this.enquiryCompany,
      this.quoteCompany,
      this.enquiryType,
      this.transportationTermsDisplay,
      this.transportationTerms,
      this.paymentTermsDisplay,
      this.paymentTerms,
      this.status,
      this.quoteCount,
      this.matchingEnquiries,
      this.uuid,
      this.otherTerms,
      this.otherAttachmentsUrl,
      this.otherAttachmentsName,
      this.enquiry});

  Content.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    lastModifiedDate = json["lastModifiedDate"];
    item = json["item"] == null
        ? null
        : (json["item"] as List).map((e) => Item.fromJson(e)).toList();
    enquiryCompany = json["enquiryCompany"] == null
        ? null
        : EnquiryCompany.fromJson(json["enquiryCompany"]);

    quoteCompany = json["quoteCompany"] == null
        ? null
        : EnquiryCompany.fromJson(json["quoteCompany"]);
    enquiryType = json["enquiryType"];
    transportationTerms = json["transportationTerms"];
    transportationTermsDisplay = json["transportationTermsDisplay"];
    paymentTerms = json["paymentTerms"];
    paymentTermsDisplay = json["paymentTermsDisplay"];
    status = json["status"];
    otherTerms = json['otherTerms'];
    quoteCount = json["quoteCount"];
    uuid = json["uuid"];
    otherAttachmentsUrl = json['otherAttachmentsUrl'];
    otherAttachmentsName = json['otherAttachmentsName'];
    matchingEnquiries = json['matchingEnquiries'];
    enquiry =
        json["enquiry"] == null ? null : Enquiry.fromJson(json["enquiry"]);
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

  EnquiryCompany({
    this.lastModifiedDate,
    this.id,
    this.name,
    this.address,
    this.pinCode,
    this.email,
    this.phone,
    this.status,
    this.locale,
    this.country,
  });

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;

    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
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
      this.price = 0,
      this.remarks,
      this.lastModifiedDate});

  Item.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    sku = json["sku"] == null ? null : Sku.fromJson(json["sku"]);
    quantity = json["quantity"];
    quantityUnit = json["quantityUnit"];
    price = json["price"] ?? 0;
    remarks = json["remarks"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sku != null) {
      data['sku'] = sku!.toJson();
    }
    data['quantity'] = quantity;
    data['quantityUnit'] = quantityUnit;
    data['remarks'] = remarks;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
