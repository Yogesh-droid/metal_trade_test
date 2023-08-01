import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_heading.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_list.dart';

class RfqDetailPage extends StatelessWidget {
  const RfqDetailPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ContextMenuAppBar(
            title: content.enquiry == null ? kEnquiryDetail : kQuoteDetails),
        body: Column(
          children: [
            EnquiryDetailHeading(
                datePosted: content.lastModifiedDate ?? '',
                status: content.status ?? '',
                uuid: content.uuid ?? ''),
            const Divider(),
            Expanded(
                child: EnquiryDetailList(
              paymentTermsDisplay: content.paymentTermsDisplay ?? '',
              transportationTermsDisplay: content.transportationTermsDisplay ?? '',
              itemList: content.item ?? [],
              otherTerms: content.otherTerms,
              filledBtnText: content.enquiry == null
                  ? kSubmitQuote
                  : content.status == 'Inreview'
                      ? kCancel
                      : null,
              onFilledTapped: () {},
              onOutlineTapped: () {},
              outlinedButtonText: kChat,
            ))
          ],
        ));
  }
}
