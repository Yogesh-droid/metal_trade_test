import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../domain/entities/post_enquiry_res_entity.dart';

class PostEnquiryResModel extends PostEnquiryResEntity {
  PostEnquiryResModel(
      {String? lastModifiedDate,
      int? id,
      List<Item>? item,
      List<Country>? country,
      EnquiryCompany? enquiryCompany,
      String? enquiryType,
      String? transportationTerms,
      String? paymentTerms,
      String? status,
      int? quoteCount,
      String? uuid})
      : super(
            country: country,
            enquiryCompany: enquiryCompany,
            enquiryType: enquiryType,
            id: id,
            item: item,
            lastModifiedDate: lastModifiedDate,
            paymentTerms: paymentTerms,
            quoteCount: quoteCount,
            status: status,
            transportationTerms: transportationTerms,
            uuid: uuid);

  factory PostEnquiryResModel.fromJson(Map<String, dynamic> json) {
    return PostEnquiryResModel(
        lastModifiedDate: json["lastModifiedDate"],
        id: json["id"],
        item: json["item"] == null
            ? null
            : (json["item"] as List).map((e) => Item.fromJson(e)).toList(),
        country: json["country"] == null
            ? null
            : (json["country"] as List)
                .map((e) => Country.fromJson(e))
                .toList(),
        enquiryCompany: json["enquiryCompany"] == null
            ? null
            : EnquiryCompany.fromJson(json["enquiryCompany"]),
        enquiryType: json["enquiryType"],
        transportationTerms: json["transportationTerms"],
        paymentTerms: json["paymentTerms"],
        status: json["status"],
        quoteCount: json["quoteCount"],
        uuid: json["uuid"]);
  }
}
