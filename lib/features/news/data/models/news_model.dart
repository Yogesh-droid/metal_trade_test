import 'package:metaltrade/features/news/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  NewsModel(
      {List<News>? news,
      int? totalPages,
      int? totalElements,
      bool? last,
      int? size,
      int? number,
      int? numberOfElements,
      bool? first,
      bool? empty})
      : super(
            first: first,
            empty: empty,
            last: last,
            news: news,
            number: number,
            numberOfElements: numberOfElements,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages);

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        news: json["content"] == null
            ? null
            : (json["content"] as List).map((e) => News.fromJson(e)).toList(),
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

class News {
  String? lastModifiedDate;
  int? id;
  String? name;
  int? price;
  int? change;
  int? volume;

  News(
      {this.lastModifiedDate,
      this.id,
      this.name,
      this.price,
      this.change,
      this.volume});

  News.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    name = json["name"];
    price = json["price"];
    change = json["change"];
    volume = json["volume"];
  }
}
