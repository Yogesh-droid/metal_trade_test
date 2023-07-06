import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/widgets/home_page_card.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';

class BuyerEnquiryPage extends StatefulWidget {
  const BuyerEnquiryPage({super.key});

  @override
  State<BuyerEnquiryPage> createState() => _BuyerEnquiryPageState();
}

class _BuyerEnquiryPageState extends State<BuyerEnquiryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileSuccessState &&
            profileState.profileEntity.company != null) {
          return BlocBuilder<HomePageBuyerEnquiryBloc,
              HomePageBuyerEnquiryState>(builder: (context, state) {
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
                          datePosted: e.enquiryCompany!.lastModifiedDate,
                          country: e.enquiryCompany!.country!.name,
                          uuid: e.uuid,
                        ))
                    .toList(),
              );
            } else if (state is HoemPageBuyerEnquiryFailed) {
              return Center(child: Text(state.exception.toString()));
            } else {
              return const Center(child: Text("Some Error"));
            }
          });
        }
        return const KycDialog();
      },
    );
  }
}
