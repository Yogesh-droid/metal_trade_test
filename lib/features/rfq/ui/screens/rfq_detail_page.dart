import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_heading.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_list.dart';

class RfqDetailPage extends StatelessWidget {
  const RfqDetailPage(
      {super.key, required this.content, required this.title, this.country});
  final Content content;
  final String title;
  final String? country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ContextMenuAppBar(title: title),
        body: Column(
          children: [
            EnquiryDetailHeading(
              datePosted: content.lastModifiedDate ?? '',
              status: content.status ?? '',
              uuid: content.uuid ?? '',
              country: country,
            ),
            const Divider(),
            Expanded(
                child: EnquiryDetailList(
              paymentTermsDisplay: content.paymentTermsDisplay ?? '',
              transportationTermsDisplay:
                  content.transportationTermsDisplay ?? '',
              itemList: content.item ?? [],
              otherTerms: content.otherTerms,
              filledBtnText: content.enquiry != null
                  ? kSubmitQuote
                  : content.status == 'Inreview' || content.status == "Active"
                      ? kCloseRfq
                      : null,
              onFilledTapped: () {
                context.read<MyRfqBloc>().add(UpdateMyRfq(
                    status: content.status == "Inreview" ||
                            content.status == "Active"
                        ? "Closed"
                        : "Active",
                    id: content.id!));
                context.pop();
              },
              onOutlineTapped: () {},
              outlinedButtonText: content.status == "Inreview" ? null : kChat,
            ))
          ],
        ));
  }
}
