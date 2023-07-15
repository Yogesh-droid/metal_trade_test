class SubmitQuoteModel {
  List<Content>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  Sort1? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  SubmitQuoteModel(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.numberOfElements,
      this.first,
      this.empty});

  SubmitQuoteModel.fromJson(Map<String, dynamic> json) {
    content = json["content"] == null
        ? null
        : (json["content"] as List).map((e) => Content.fromJson(e)).toList();
    pageable =
        json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]);
    totalPages = json["totalPages"];
    totalElements = json["totalElements"];
    last = json["last"];
    size = json["size"];
    number = json["number"];
    sort = json["sort"] == null ? null : Sort1.fromJson(json["sort"]);
    numberOfElements = json["numberOfElements"];
    first = json["first"];
    empty = json["empty"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data["content"] = content?.map((e) => e.toJson()).toList();
    }
    if (pageable != null) {
      data["pageable"] = pageable?.toJson();
    }
    data["totalPages"] = totalPages;
    data["totalElements"] = totalElements;
    data["last"] = last;
    data["size"] = size;
    data["number"] = number;
    if (sort != null) {
      data["sort"] = sort?.toJson();
    }
    data["numberOfElements"] = numberOfElements;
    data["first"] = first;
    data["empty"] = empty;
    return data;
  }
}

class Sort1 {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort1({this.empty, this.sorted, this.unsorted});

  Sort1.fromJson(Map<String, dynamic> json) {
    empty = json["empty"];
    sorted = json["sorted"];
    unsorted = json["unsorted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["empty"] = empty;
    data["sorted"] = sorted;
    data["unsorted"] = unsorted;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? unpaged;
  bool? paged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.unpaged,
      this.paged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json["sort"] == null ? null : Sort.fromJson(json["sort"]);
    offset = json["offset"];
    pageNumber = json["pageNumber"];
    pageSize = json["pageSize"];
    unpaged = json["unpaged"];
    paged = json["paged"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data["sort"] = sort?.toJson();
    }
    data["offset"] = offset;
    data["pageNumber"] = pageNumber;
    data["pageSize"] = pageSize;
    data["unpaged"] = unpaged;
    data["paged"] = paged;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json["empty"];
    sorted = json["sorted"];
    unsorted = json["unsorted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["empty"] = empty;
    data["sorted"] = sorted;
    data["unsorted"] = unsorted;
    return data;
  }
}

class Content {
  String? lastModifiedDate;
  int? id;
  int? senderCompanyId;
  int? recipientCompanyId;
  int? enquiryId;
  int? quoteId;
  Body? body;
  String? status;

  Content(
      {this.lastModifiedDate,
      this.id,
      this.senderCompanyId,
      this.recipientCompanyId,
      this.enquiryId,
      this.quoteId,
      this.body,
      this.status});

  Content.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    senderCompanyId = json["senderCompanyId"];
    recipientCompanyId = json["recipientCompanyId"];
    enquiryId = json["enquiryId"];
    quoteId = json["quoteId"];
    body = json["body"] == null ? null : Body.fromJson(json["body"]);
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lastModifiedDate"] = lastModifiedDate;
    data["id"] = id;
    data["senderCompanyId"] = senderCompanyId;
    data["recipientCompanyId"] = recipientCompanyId;
    data["enquiryId"] = enquiryId;
    data["quoteId"] = quoteId;
    if (body != null) {
      data["body"] = body?.toJson();
    }
    data["status"] = status;
    return data;
  }
}

class Body {
  int? id;
  Quote? quote;

  Body({this.id, this.quote});

  Body.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quote = json["quote"] == null ? null : Quote.fromJson(json["quote"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (quote != null) {
      data["quote"] = quote?.toJson();
    }
    return data;
  }
}

class Quote {
  int? id;
  List<Item>? item;
  String? status;
  String? uuid;

  Quote({this.id, this.item, this.status, this.uuid});

  Quote.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    item = json["item"] == null
        ? null
        : (json["item"] as List).map((e) => Item.fromJson(e)).toList();
    status = json["status"];
    uuid = json["uuid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (item != null) {
      data["item"] = item?.map((e) => e.toJson()).toList();
    }
    data["status"] = status;
    data["uuid"] = uuid;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (sku != null) {
      data["sku"] = sku?.toJson();
    }
    data["quantity"] = quantity;
    data["quantityUnit"] = quantityUnit;
    data["price"] = price;
    data["remarks"] = remarks;
    return data;
  }
}

class Sku {
  int? id;
  String? title;

  Sku({this.id, this.title});

  Sku.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    return data;
  }
}
