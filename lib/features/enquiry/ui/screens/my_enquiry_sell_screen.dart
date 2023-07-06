import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';

import '../../../home/ui/widgets/home_page_card.dart';

class MyEnquirySellScreen extends StatelessWidget {
  const MyEnquirySellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEnquirySellBloc, MyEnquirySellState>(
        builder: (context, state) {
      if (state is MyEnquirySellInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MyEnquirySellFetchedState) {
        return ListView(
          shrinkWrap: true,
          children: state.contentList
              .map((e) => HomePageCard(
                    isSeller: true,
                    companyAddress: e.enquiryCompany!.address,
                    enquiryCommpanyName: e.enquiryCompany!.name,
                    itemList: e.item,
                    ownerName: e.enquiryCompany!.name,
                    datePosted: e.enquiryCompany!.lastModifiedDate,
                    country: e.enquiryCompany!.country!.name,
                    uuid: e.uuid,
                  ))
              .toList(),
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
