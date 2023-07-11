import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';

import '../../../rfq/ui/widgets/home_page_card.dart';

class MyQuoteScreen extends StatelessWidget {
  const MyQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyQuoteBloc, MyQuoteState>(builder: (context, state) {
      if (state is MyQuoteInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MyQuoteFetchedState) {
        return ListView(
          shrinkWrap: true,
          children: state.contentList
              .map((e) => HomePageCard(
                    content: e,
                    itemList: e.item,
                    country: e.enquiryCompany!.country!.name,
                    uuid: e.uuid,
                    filledBtnTitle: e.status == 'Inreview' ? "kCancel" : null,
                    borderedBtnTitle: kChat,
                    onBorderedBtnTapped: () {},
                    onFilledBtnTapped: () {},
                  ))
              .toList(),
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
