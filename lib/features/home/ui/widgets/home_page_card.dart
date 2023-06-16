import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_colors.dart';

import '../../data/models/home_page_enquiry_model.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard(
      {super.key,
      required this.isSeller,
      this.enquiryCommpanyName,
      this.companyAddress,
      this.ownerName,
      this.sellingFrom,
      this.datePosted,
      this.itemList});
  final bool isSeller;
  final String? enquiryCommpanyName;
  final String? companyAddress;
  final String? ownerName;
  final String? sellingFrom;
  final String? datePosted;
  final List<Item>? itemList;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        color: grey7,
        child: Column(children: [
          Row(
            children: [
              Column(children: [
                Text(enquiryCommpanyName ?? ''),
                Text(ownerName ?? ''),
                Text(companyAddress ?? ''),
              ]),
              Column(children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.person)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.message_outlined)),
                  ],
                ),
                const Text("Date posted")
              ])
            ],
          ),
          const Divider(),
          if (isSeller)
            Text("Sell From : $sellingFrom")
          else
            Text('Wants to buy from $sellingFrom')
        ]),
      ),
    );
  }
}
