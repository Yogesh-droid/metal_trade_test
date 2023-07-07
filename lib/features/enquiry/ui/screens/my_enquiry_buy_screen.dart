import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/ui/widgets/home_page_card.dart';
import '../controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';

class MyEnquiryBuyScreen extends StatelessWidget {
  const MyEnquiryBuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEnquiryBloc, MyEnquiryState>(
        builder: (context, state) {
      if (state is MyEnquiryInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MyEnquiryFetchedState) {
        return ListView(
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
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
