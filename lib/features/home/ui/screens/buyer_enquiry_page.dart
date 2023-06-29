import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/widgets/home_page_card.dart';

class BuyerEnquiryPage extends StatefulWidget {
  const BuyerEnquiryPage({super.key});

  @override
  State<BuyerEnquiryPage> createState() => _BuyerEnquiryPageState();
}

class _BuyerEnquiryPageState extends State<BuyerEnquiryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBuyerEnquiryBloc, HomePageBuyerEnquiryState>(
        builder: (context, state) {
      if (state is HomePageBuyerEnquiryInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is HomePageBuyerEnquiryFetchedState) {
        return ListView(
          shrinkWrap: true,
          children: state.buyerEnquiryList
              .map((e) => HomePageCard(
                  isSeller: false,
                  companyAddress: e.enquiryCompany!.address,
                  enquiryCommpanyName: e.enquiryCompany!.name,
                  itemList: e.item,
                  ownerName: e.enquiryCompany!.name,
                  datePosted: e.enquiryCompany!.lastModifiedDate))
              .toList(),
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
