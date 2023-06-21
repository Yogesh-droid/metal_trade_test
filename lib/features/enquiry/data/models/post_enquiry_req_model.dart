class PostEnquiryModel {
  String? enquiryType;
  String? transportationTerms;
  String? paymentTerms;
  String? deliveryTerms;
  List<Country>? country;
  List<Item>? item;

  PostEnquiryModel(
      {this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.country,
      this.item});

  PostEnquiryModel.fromJson(Map<String, dynamic> json) {
    enquiryType = json['enquiryType'];
    transportationTerms = json['transportationTerms'];
    paymentTerms = json['paymentTerms'];
    deliveryTerms = json['deliveryTerms'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
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
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
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
  int? price;
  String? remarks;
  Country? sku;

  Item({this.quantity, this.quantityUnit, this.price, this.remarks, this.sku});

  Item.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    quantityUnit = json['quantityUnit'];
    price = json['price'];
    remarks = json['remarks'];
    sku = json['sku'] != null ? Country.fromJson(json['sku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['quantityUnit'] = quantityUnit;
    data['price'] = price;
    data['remarks'] = remarks;
    if (sku != null) {
      data['sku'] = sku!.toJson();
    }
    return data;
  }
}
