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
  String? status;
  double? totalValue;
  String? uuid;

  Content(
      {this.lastModifiedDate,
      this.id,
      this.quote,
      this.enquiry,
      this.item,
      this.transportationTerms,
      this.paymentTerms,
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
    status = json["status"];
    totalValue = json["totalValue"];
    uuid = json["uuid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastModifiedDate'] = lastModifiedDate;
    data['id'] = id;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    if (enquiry != null) {
      data['enquiry'] = enquiry!.toJson();
    }
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    data['transportationTerms'] = transportationTerms;
    data['transportationTermsDisplay'] = transportationTerms;
    data['paymentTerms'] = paymentTerms;
    data['paymentTermsDisplay'] = paymentTerms;
    data['status'] = status;
    data['totalValue'] = totalValue;
    data['uuid'] = uuid;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (enquiryCompany != null) {
      data['enquiryCompany'] = enquiryCompany!.toJson();
    }
    data['enquiryType'] = enquiryType;
    data['uuid'] = uuid;
    return data;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (quoteCompany != null) {
      data['quoteCompany'] = quoteCompany!.toJson();
    }
    data['uuid'] = uuid;
    return data;
  }
}
