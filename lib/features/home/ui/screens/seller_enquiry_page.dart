import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';

class SellerEnquiryPage extends StatefulWidget {
  const SellerEnquiryPage({super.key});

  @override
  State<SellerEnquiryPage> createState() => _SellerEnquiryPageState();
}

class _SellerEnquiryPageState extends State<SellerEnquiryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageSellerEnquiryBloc, HomePageSellerEnquiryState>(
        builder: (context, state) {
      if (state is HomePageSellerEnquiryInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is HomePageSellerEnquiryFetchedState) {
        return ListView(
          shrinkWrap: true,
          children: state.sellerEnquiryList
              .map((e) => SizedBox(
                  height: 150, child: Center(child: Text(e.id.toString()))))
              .toList(),
        );
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
