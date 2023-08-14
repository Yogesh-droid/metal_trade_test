import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/quote_detail_screen.dart';
import 'package:metaltrade/features/profile/ui/widgets/confirmation_sheet.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_heading.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_list.dart';

import '../../../../core/constants/app_widgets/context_menu_app_bar.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/routes.dart';
import '../controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';

class MyEnquiryDetail extends StatefulWidget {
  const MyEnquiryDetail({super.key, required this.item, this.initialTab});
  final Content item;
  final int? initialTab;

  @override
  State<MyEnquiryDetail> createState() => _MyEnquiryDetailState();
}

class _MyEnquiryDetailState extends State<MyEnquiryDetail>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    context.read<QuoteDetailListBloc>().add(GetQuoteDetailList(
        page: 0, enquiryId: widget.item.id!, isLoadMore: false));
    tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTab ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContextMenuAppBar(title: kEnquiryDetail.tr()),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: appPadding),
        EnquiryDetailHeading(
            datePosted: widget.item.lastModifiedDate ?? '',
            status: widget.item.status ?? '',
            uuid: widget.item.uuid ?? ''),
        const SizedBox(height: appPadding),
        const Divider(),
        TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            automaticIndicatorColorAdjustment: true,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: kDetails.tr()),
              Tab(text: ("${kQuote.tr()} (${widget.item.quoteCount})"))
            ]),
        const SizedBox(height: appPadding),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            EnquiryDetailList(
              otherAttachmentsName: widget.item.otherAttachmentsName != null
                  ? widget.item.otherAttachmentsName!
                      .split(RegExp(r'[/_-]'))
                      .last
                  : null,
              otherAttachmentsUrl: widget.item.otherAttachmentsUrl,
              paymentTermsDisplay: widget.item.paymentTermsDisplay ?? '',
              transportationTermsDisplay:
                  widget.item.transportationTermsDisplay ?? '',
              itemList: widget.item.item!,
              isIcon: widget.item.status == "Complete" ||
                      widget.item.status == "Expired"
                  ? true
                  : false,
              outlinedButtonText: widget.item.status == "Complete"
                  ? kViewOrder.tr()
                  : widget.item.status == "Inreview" ||
                          widget.item.status == "Active"
                      ? kCloseRfq.tr()
                      : widget.item.status == "Expired"
                          ? kReopen.tr()
                          : null,
              onOutlineTapped: () {
                if (widget.item.status == "Inreview" ||
                    widget.item.status == "Active") {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ConfirmationSheet(
                            explanation: kThisWillRemoveRfq.tr(),
                            height: MediaQuery.of(context).size.height / 3,
                            onConfirmTapped: () {
                              context.read<MyRfqBloc>().add(UpdateMyRfq(
                                  status: "Closed", id: widget.item.id!));
                              context.pop();
                              context.pop();
                            },
                            filledBtnText: kClose.tr(),
                            outlinedBtnText: kCancel.tr(),
                            title: kAreYouSureCloseRfq.tr());
                      });
                } else if (widget.item.status == "Complete") {
                  context.pushNamed(myOrderScreenName);
                }
              },
            ),
            QuoteDetailScreen(content: widget.item)
          ]),
        )
      ]),
    );
  }
}
