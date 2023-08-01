import 'package:metaltrade/features/quotes/data/models/quote_res_model.dart';

import '../../../rfq/data/models/rfq_enquiry_model.dart';

class AcceptQuoteResEntity {
  final String? lastModifiedDate;
  final int? id;
  final EnquiryCompany? quoteCompany;
  final Enquiry? enquiry;
  final List<Item>? item;
  final String? transportationTerms;
  final String? paymentTerms;
  final String? deliveryTerms;
  final String? status;
  final String? uuid;

  AcceptQuoteResEntity(
      {this.lastModifiedDate,
      this.id,
      this.quoteCompany,
      this.enquiry,
      this.item,
      this.transportationTerms,
      this.paymentTerms,
      this.deliveryTerms,
      this.status,
      this.uuid});
}
