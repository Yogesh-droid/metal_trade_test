import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';

import '../../../../core/constants/app_widgets/context_menu_app_bar.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../rfq/ui/widgets/enquiry_detail_heading.dart';
import '../../../rfq/ui/widgets/enquiry_detail_list.dart';

class MyQuoteDetailPage extends StatelessWidget {
  const MyQuoteDetailPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ContextMenuAppBar(title: "kQuoteDetails"),
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
              transportationTermsDisplay:
                  content.transportationTermsDisplay ?? '',
              itemList: content.item ?? [],
              otherTerms: content.otherTerms,
              filledBtnText:
                  content.status == 'Inreview' || content.status == "Active"
                      ? kCancel
                      : null,
              onFilledTapped: () {},
              onOutlineTapped: () {},
              outlinedButtonText: content.status == "Inreview" ? null : kChat,
            ))
          ],
        ));
  }
}
