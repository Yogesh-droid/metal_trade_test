import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;

import '../../../../core/constants/app_widgets/context_menu_app_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart' as quote_res;
import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../rfq/ui/widgets/enquiry_detail_heading.dart';
import '../../../rfq/ui/widgets/enquiry_detail_list.dart';

class MyQuoteDetailPage extends StatelessWidget {
  const MyQuoteDetailPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ContextMenuAppBar(title: kQuoteDetails),
        body: Column(
          children: [
            EnquiryDetailHeading(
                datePosted: content.lastModifiedDate ?? '',
                status: content.status ?? '',
                uuid: content.uuid ?? ''),
            const Divider(),
            Expanded(
                child: EnquiryDetailList(
              isPriceShown: true,
              paymentTermsDisplay: content.paymentTermsDisplay ?? '',
              transportationTermsDisplay:
                  content.transportationTermsDisplay ?? '',
              itemList: content.item ?? [],
              otherTerms: content.otherTerms,
              filledBtnText: content.status == 'Inreview' ? kCancel : null,
              onFilledTapped: () {},
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
              outlinedButtonText: content.status == "Inreview" ? null : kChat,
            ))
          ],
        ));
  }
}
