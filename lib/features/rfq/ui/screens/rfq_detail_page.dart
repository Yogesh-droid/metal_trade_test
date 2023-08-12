import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_heading.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_list.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;

import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../profile/ui/widgets/confirmation_sheet.dart';
import '../../../quotes/data/models/quote_res_model.dart' as quote_res_model;

class RfqDetailPage extends StatelessWidget {
  const RfqDetailPage(
      {super.key,
      required this.content,
      required this.title,
      this.country,
      required this.isMyEnquiry,
      this.hideBtns});
  final Content content;
  final String title;
  final String? country;
  final String? isMyEnquiry;
  final String? hideBtns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ContextMenuAppBar(title: title),
        body: Column(
          children: [
            EnquiryDetailHeading(
              datePosted: content.lastModifiedDate ?? '',
              status: content.status ?? '',
              // Hide btn below means no CTA that is used
              // only for enquiryDetail, no action needed i.e. redirected from MyQuotes
              uuid: hideBtns != null
                  ? content.enquiry!.uuid ?? ''
                  : content.uuid ?? '',
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
              otherAttachmentsName: content.otherAttachmentsName != null
                  ? content.otherAttachmentsName!.split(RegExp(r'[/_-]')).last
                  : null,
              otherAttachmentsUrl: content.otherAttachmentsUrl,
              filledBtnText: hideBtns != null
                  ? null
                  : isMyEnquiry != null
                      ? kSubmitQuote
                      : content.status == 'Inreview' ||
                              content.status == "Active"
                          ? kCloseRfq
                          : null,
              onFilledTapped: hideBtns != null
                  ? null
                  : () {
                      if (isMyEnquiry != null) {
                        context.pushReplacementNamed(submitQuotePageName,
                            extra: content);
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ConfirmationSheet(
                                  explanation: kThisWillRemoveRfq.tr(),
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  onConfirmTapped: () {
                                    context.read<MyRfqBloc>().add(UpdateMyRfq(
                                        status: content.status == "Inreview" ||
                                                content.status == "Active"
                                            ? "Closed"
                                            : "Active",
                                        id: content.id!));
                                    context.pop();
                                    context.pop();
                                  },
                                  filledBtnText: kClose,
                                  outlinedBtnText: kCancel.tr(),
                                  title: kAreYouSureCloseRfq.tr());
                            });
                      }
                    },
              onOutlineTapped: hideBtns != null
                  ? null
                  : () {
                      context.read<ChatBloc>().add(GetPreviousChatEvent(
                          chatType: ChatType.enquiry.name,
                          enquiryId: content.id,
                          page: 0));
                      context.pushNamed(chatPageName,
                          queryParameters: {'room': content.uuid ?? ''},
                          extra: chat_res.Content(
                              body: chat_res.Body(
                                chatMessageType: "Enquiry",
                                enquiry: quote_res_model.Enquiry(
                                  lastModifiedDate: DateTime.now().toString(),
                                  id: content.id,
                                  item: content.item,
                                  uuid: content.uuid,
                                ),
                              ),
                              enquiryId: content.id,
                              lastModifiedDate: DateTime.now(),
                              status: "Unseen"));
                    },
              outlinedButtonText: hideBtns != null
                  ? null
                  : content.status == "Inreview"
                      ? null
                      : kChat.tr(),
            ))
          ],
        ));
  }
}
