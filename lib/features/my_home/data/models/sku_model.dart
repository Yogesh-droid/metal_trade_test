import '../../domain/entities/sku_entity.dart';

class SkuModel extends SkuEntity {
  SkuModel(
      {List<Content>? content,
      int? totalPages,
      int? totalElements,
      bool? last,
      int? size,
      int? number,
      int? numberOfElements,
      bool? first,
      final bool? empty})
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

  factory SkuModel.fromJson(Map<String, dynamic> json) {
    return SkuModel(
      content: json["content"] == null
          ? null
          : (json["content"] as List).map((e) => Content.fromJson(e)).toList(),
      totalPages: json["totalPages"],
      totalElements: json["totalElements"],
      last: json["last"],
      size: json["size"],
      number: json["number"],
      numberOfElements: json["numberOfElements"],
      first: json["first"],
      empty: json["empty"],
    );
  }
}

class Content {
  int? id;
  String? title;

  Content({this.id, this.title});

  Content.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }
}
