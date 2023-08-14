import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;

import '../../../../core/constants/app_widgets/context_menu_app_bar.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart' as quote_res;
import '../../../quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../rfq/ui/widgets/enquiry_detail_heading.dart';
import '../../../rfq/ui/widgets/enquiry_detail_list.dart';

class MyQuoteDetailPage extends StatelessWidget {
  const MyQuoteDetailPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ContextMenuAppBar(title: kQuoteDetails.tr()),
        body: Column(
          children: [
            EnquiryDetailHeading(
              datePosted: content.lastModifiedDate ?? '',
              status: content.status ?? '',
              uuidTitle: Text.rich(TextSpan(children: [
                TextSpan(
                  text: '${content.uuid}',
                  style: secMed12.copyWith(color: Colors.black),
                ),
                const TextSpan(text: ' on '),
                TextSpan(
                    text: '${content.enquiry!.uuid}',
                    style: secMed12.copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed(enquiryDetailPageName,
                            extra: content,
                            queryParameters: {
                              'title': kEnquiryDetail.tr(),
                              'isMyEnquiry': 'yes',
                              'hideBtn': 'yes'
                            });
                      })
              ])),
            ),
            const Divider(),
            Expanded(
                child: EnquiryDetailList(
              isPriceShown: true,
              paymentTermsDisplay: content.paymentTermsDisplay ?? '',
              transportationTermsDisplay:
                  content.transportationTermsDisplay ?? '',
              itemList: content.item ?? [],
              otherTerms: content.otherTerms,
              filledBtnText: content.status == 'Inreview' ? kCancel.tr() : null,
              onFilledTapped: () {
                context.read<AcceptQuoteBloc>().add(QuoteCancelEvent(
                    quoteId: content.id ?? 0, status: 'Closed'));
                context.pop();
              },
              onOutlineTapped: () {
                context.read<ChatBloc>().add(GetPreviousChatEvent(
                    chatType: ChatType.quote.name,
                    quoteId: content.id,
                    page: 0));
                context.pushNamed(chatPageName,
                    queryParameters: {'room': content.uuid ?? ''},
                    extra: chat_res.Content(
                        body: chat_res.Body(
                          chatMessageType: "Quote",
                          quote: quote_res.Enquiry(
                            lastModifiedDate: DateTime.now().toString(),
                            id: content.id,
                            item: content.item,
                            uuid: content.uuid,
                          ),
                        ),
                        quoteId: content.id,
                        enquiryId: content.enquiry!.id!,
                        lastModifiedDate: DateTime.now(),
                        status: "Unseen"));
              },
              isIcon: true,
              outlinedButtonText:
                  content.status == "Inreview" ? null : kChat.tr(),
            ))
          ],
        ));
  }
}
