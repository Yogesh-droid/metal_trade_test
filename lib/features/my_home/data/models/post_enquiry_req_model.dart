class PostEnquiryModel {
  String? enquiryType;
  String? transportationTerms;
  String? paymentTerms;
  List<Item>? item;
  String? remarks;
  String? otherAttachmentsUrl;

  PostEnquiryModel(
      {this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.item,
      this.remarks,
      this.otherAttachmentsUrl});

  PostEnquiryModel.fromJson(Map<String, dynamic> json) {
    enquiryType = json['enquiryType'];
    transportationTerms = json['transportationTerms'];
    paymentTerms = json['paymentTerms'];
    remarks = json['remarks'];
    otherAttachmentsUrl = json['otherAttachmentsUrl'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enquiryType'] = enquiryType;
    data['transportationTerms'] = transportationTerms;
    data['paymentTerms'] = paymentTerms;
    data['remarks'] = remarks;
    data['otherAttachmentsUrl'] = otherAttachmentsUrl;
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  int? id;

  Country({this.id});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Item {
  int? quantity;
  String? quantityUnit;
  String? remarks;
  double? price;
  Country? sku;

  Item({this.quantity, this.quantityUnit, this.remarks, this.sku, this.price});

  Item.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    quantityUnit = json['quantityUnit'];
    remarks = json['remarks'];
    price = json['price'];
    sku = json['sku'] != null ? Country.fromJson(json['sku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['quantityUnit'] = quantityUnit;
    data['remarks'] = remarks;
    data["price"] = price;
    if (sku != null) {
      data['sku'] = sku!.toJson();
    }
    return data;
  }
}
