import '../../data/models/sku_model.dart';

class SkuEntity {
  final List<Content>? content;
  final int? totalPages;
  final int? totalElements;
  final bool? last;
  final int? size;
  final int? number;
  final int? numberOfElements;
  final bool? first;
  final bool? empty;

  SkuEntity(
      {this.content,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.numberOfElements,
      this.first,
      this.empty});
}
