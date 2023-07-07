import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';

import '../../../rfq/ui/widgets/home_page_card.dart';

class MyRfqScreen extends StatelessWidget {
  const MyRfqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyRfqBloc, MyRfqState>(builder: (context, state) {
      print(state);
      if (state is MyRfqInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MyRfqFetchedState) {
        return Column(
          children: [
            const FilterChipList(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: state.contentList
                    .map((e) => HomePageCard(
                          content: e,
                          isSeller: false,
                          companyAddress: e.enquiryCompany!.address,
                          enquiryCommpanyName: e.enquiryCompany!.name,
                          itemList: e.item,
                          ownerName: e.enquiryCompany!.name,
                          datePosted: e.enquiryCompany!.lastModifiedDate,
                          country: e.enquiryCompany!.country!.name,
                          uuid: e.uuid,
                        ))
                    .toList(),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
