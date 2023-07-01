import 'package:metaltrade/features/profile/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({int? id, String? name}) : super(id: id, name: name);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(id: json["id"], name: json["name"]);
  }
}
