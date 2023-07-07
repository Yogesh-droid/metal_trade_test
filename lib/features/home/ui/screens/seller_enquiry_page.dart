import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import '../widgets/home_page_card.dart';

class SellerEnquiryPage extends StatefulWidget {
  const SellerEnquiryPage({super.key});

  @override
  State<SellerEnquiryPage> createState() => _SellerEnquiryPageState();
}

class _SellerEnquiryPageState extends State<SellerEnquiryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.profileEntity.company != null) {
            return BlocBuilder<HomePageSellerEnquiryBloc,
                HomePageSellerEnquiryState>(builder: (context, state) {
              if (state is HomePageSellerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomePageSellerEnquiryFetchedState) {
                return ListView(
                  shrinkWrap: true,
                  children: state.sellerEnquiryList
                      .map((e) => HomePageCard(
                            content: e,
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
              } else if (state is HoemPageSellerEnquiryFailed) {
                return Center(child: Text(state.exception.toString()));
              } else {
                return const Center(child: Text("Some Error"));
              }
            });
          } else {
            return const KycDialog();
          }
        }
        return const SizedBox(
          child: Center(child: LoadingDots()),
        );
      },
    );
  }
}
