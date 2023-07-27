import 'package:metaltrade/features/profile/domain/entities/my_order_entity.dart';

import '../../../rfq/data/models/rfq_enquiry_model.dart';

class MyOrderModel extends MyOrderEntity {
  MyOrderModel(
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

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
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
  Quote? quote;
  Enquiry? enquiry;
  List<Item>? item;
  String? transportationTerms;
  String? paymentTerms;
  String? deliveryTerms;
  String? status;
  int? totalValue;
  String? uuid;

  Content(
      {this.lastModifiedDate,
      this.id,
      this.quote,
      this.enquiry,
      this.item,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.status,
      this.totalValue,
      this.uuid});

  Content.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    quote = json["quote"] == null ? null : Quote.fromJson(json["quote"]);
    enquiry =
        json["enquiry"] == null ? null : Enquiry.fromJson(json["enquiry"]);
    item = json["item"] == null
        ? null
        : (json["item"] as List).map((e) => Item.fromJson(e)).toList();
    transportationTerms = json["transportationTerms"];
    paymentTerms = json["paymentTerms"];
    deliveryTerms = json["deliveryTerms"];
    status = json["status"];
    totalValue = json["totalValue"];
    uuid = json["uuid"];
  }
}

class Item {
  int? id;
  Sku? sku;
  int? quantity;
  String? quantityUnit;
  int? price;
  String? remarks;

  Item(
      {this.id,
      this.sku,
      this.quantity,
      this.quantityUnit,
      this.price,
      this.remarks});

  Item.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sku = json["sku"] == null ? null : Sku.fromJson(json["sku"]);
    quantity = json["quantity"];
    quantityUnit = json["quantityUnit"];
    price = json["price"];
    remarks = json["remarks"];
  }
}

class Enquiry {
  int? id;
  EnquiryCompany? enquiryCompany;
  String? enquiryType;
  String? uuid;

  Enquiry({this.id, this.enquiryCompany, this.enquiryType, this.uuid});

  Enquiry.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    enquiryCompany = json["enquiryCompany"] == null
        ? null
        : EnquiryCompany.fromJson(json["enquiryCompany"]);
    enquiryType = json["enquiryType"];
    uuid = json["uuid"];
  }
}

class Quote {
  int? id;
  EnquiryCompany? quoteCompany;
  String? uuid;

  Quote({this.id, this.quoteCompany, this.uuid});

  Quote.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quoteCompany = json["quoteCompany"] == null
        ? null
        : EnquiryCompany.fromJson(json["quoteCompany"]);
    uuid = json["uuid"];
  }
}
