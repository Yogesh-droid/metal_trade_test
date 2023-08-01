import '../../../rfq/data/models/rfq_enquiry_model.dart';

class PostEnquiryResEntity {
  final String? lastModifiedDate;
  final int? id;
  final List<Item>? item;
  final List<Country>? country;
  final EnquiryCompany? enquiryCompany;
  final String? enquiryType;
  final String? transportationTerms;
  final String? paymentTerms;
  final String? status;
  final int? quoteCount;
  final String? uuid;

  PostEnquiryResEntity(
      {this.lastModifiedDate,
      this.id,
      this.item,
      this.country,
      this.enquiryCompany,
      this.enquiryType,
      this.transportationTerms,
      this.paymentTerms,
      this.status,
      this.quoteCount,
      this.uuid});
}
