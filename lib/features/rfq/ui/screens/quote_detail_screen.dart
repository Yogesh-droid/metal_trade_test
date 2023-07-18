import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/quote_detail_card.dart';

class QuoteDetailScreen extends StatelessWidget {
  const QuoteDetailScreen({super.key, required this.content});
  final Content content;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: content.item!
          .map((e) => QuoteDetailCard(
                item: e,
                uuid: content.uuid!,
                lastDateModified: content.lastModifiedDate,
                outlinedBtnText: kChat,
                onOutlinedBtnTapped: () {},
                filledBtnText: kAccept,
                onFilledBtnTapped: () {},
              ))
          .toList(),
    );
  }
}
