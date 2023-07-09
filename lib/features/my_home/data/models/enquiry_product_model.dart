class EnquiryProductModel {
  int? id;
  String? unit;
  String? quantity;

  EnquiryProductModel({this.id, this.unit, this.quantity});

  EnquiryProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit = json['unit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit'] = unit;
    data['quantity'] = quantity;
    return data;
  }
}
