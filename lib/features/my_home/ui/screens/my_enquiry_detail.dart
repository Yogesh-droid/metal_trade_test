import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/quote_detail_screen.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_heading.dart';
import 'package:metaltrade/features/rfq/ui/widgets/enquiry_detail_list.dart';

import '../../../../core/constants/app_widgets/context_menu_app_bar.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';

class MyEnquiryDetail extends StatefulWidget {
  const MyEnquiryDetail({super.key, required this.item});
  final Content item;

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
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(title: kEnquiryDetail),
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
            tabs: const [Tab(text: kDetails), Tab(text: kQuote)]),
        const SizedBox(height: appPadding),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            EnquiryDetailList(
              paymentTerms: widget.item.paymentTerms ?? '',
              transportationTerms: widget.item.transportationTerms ?? '',
              deliveryTerms: widget.item.deliveryTerms ?? '',
              itemList: widget.item.item!,
              outlinedButtonText:
                  widget.item.status == "Complete" ? kReopen : kCloseRfq,
              onOutlineTapped: () {},
            ),
            QuoteDetailScreen(content: widget.item)
          ]),
        )
      ]),
    );
  }
}
