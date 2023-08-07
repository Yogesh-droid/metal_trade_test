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
import '../../../quotes/data/models/quote_res_model.dart' as quote_res_model;

class RfqDetailPage extends StatelessWidget {
  const RfqDetailPage(
      {super.key,
      required this.content,
      required this.title,
      this.country,
      required this.isMyEnquiry});
  final Content content;
  final String title;
  final String? country;
  final String? isMyEnquiry;

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
              filledBtnText: isMyEnquiry != null
                  ? kSubmitQuote
                  : content.status == 'Inreview' || content.status == "Active"
                      ? kCloseRfq
                      : null,
              onFilledTapped: () {
                if (isMyEnquiry != null) {
                  context.pushReplacementNamed(submitQuotePageName,
                      extra: content);
                } else {
                  context.read<MyRfqBloc>().add(UpdateMyRfq(
                      status: content.status == "Inreview" ||
                              content.status == "Active"
                          ? "Closed"
                          : "Active",
                      id: content.id!));
                  context.pop();
                }
              },
              onOutlineTapped: () {
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
              outlinedButtonText: content.status == "Inreview" ? null : kChat,
            ))
          ],
        ));
  }
}
