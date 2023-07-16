class PostEnquiryModel {
  String? enquiryType;
  String? transportationTerms;
  String? paymentTerms;
  String? deliveryTerms;
  List<Item>? item;
  String? remarks;

  PostEnquiryModel(
      {this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.item,
      this.remarks});

  PostEnquiryModel.fromJson(Map<String, dynamic> json) {
    enquiryType = json['enquiryType'];
    transportationTerms = json['transportationTerms'];
    paymentTerms = json['paymentTerms'];
    remarks = json['remarks'];
    deliveryTerms = json['deliveryTerms'];
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
    data['deliveryTerms'] = deliveryTerms;
    data['remarks'] = remarks;
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
  Country? sku;

  Item({this.quantity, this.quantityUnit, this.remarks, this.sku});

  Item.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    quantityUnit = json['quantityUnit'];
    remarks = json['remarks'];
    sku = json['sku'] != null ? Country.fromJson(json['sku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['quantityUnit'] = quantityUnit;
    data['remarks'] = remarks;
    if (sku != null) {
      data['sku'] = sku!.toJson();
    }
    return data;
  }
}
