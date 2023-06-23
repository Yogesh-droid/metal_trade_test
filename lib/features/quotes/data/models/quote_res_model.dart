import 'package:metaltrade/features/quotes/domain/entities/accept_quote_res_entity.dart';
import 'package:metaltrade/features/quotes/domain/entities/quote_res_entity.dart';

import '../../../home/data/models/home_page_enquiry_model.dart';

class QuoteResModel extends QuoteResEntity {
  QuoteResModel(
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

  factory QuoteResModel.fromJson(Map<String, dynamic> json) {
    return QuoteResModel(
        content: json["content"] == null
            ? null
            : (json["content"] as List)
                .map((e) => Content.fromJson(e))
                .toList(),
        empty: json['empty'],
        first: json['first'],
        last: json['last'],
        number: json['number'],
        numberOfElements: json['numberOfElements'],
        size: json['size'],
        totalElements: json['totalElements'],
        totalPages: json['totalPages']);
  }
}

class Content extends AcceptQuoteResEntity {
  Content(
      {String? lastModifiedDate,
      int? id,
      EnquiryCompany? quoteCompany,
      Enquiry? enquiry,
      List<Item>? item,
      String? transportationTerms,
      String? paymentTerms,
      String? deliveryTerms,
      String? status,
      String? uuid});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        lastModifiedDate: json["lastModifiedDate"],
        id: json["id"],
        quoteCompany: json["quoteCompany"] == null
            ? null
            : EnquiryCompany.fromJson(json["quoteCompany"]),
        enquiry:
            json["enquiry"] == null ? null : Enquiry.fromJson(json["enquiry"]),
        item: json["item"] == null
            ? null
            : (json["item"] as List).map((e) => Item.fromJson(e)).toList(),
        transportationTerms: json["transportationTerms"],
        paymentTerms: json["paymentTerms"],
        deliveryTerms: json["deliveryTerms"],
        status: json["status"],
        uuid: json["uuid"]);
  }
}

class Enquiry {
  String? lastModifiedDate;
  int? id;
  List<Item>? item;
  List<Country>? country;
  EnquiryCompany? enquiryCompany;
  String? enquiryType;
  String? transportationTerms;
  String? paymentTerms;
  String? deliveryTerms;
  String? status;
  int? quoteCount;
  String? uuid;
  int? matchingEnquiries;

  Enquiry(
      {this.lastModifiedDate,
      this.id,
      this.item,
      this.country,
      this.enquiryCompany,
      this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.status,
      this.quoteCount,
      this.uuid,
      this.matchingEnquiries});

  Enquiry.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    item = json["item"] == null
        ? null
        : (json["item"] as List).map((e) => Item.fromJson(e)).toList();
    country = json["country"] == null
        ? null
        : (json["country"] as List).map((e) => Country.fromJson(e)).toList();
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
    matchingEnquiries = json["matchingEnquiries"];
  }
}
