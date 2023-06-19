import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_colors.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/enquiry/ui/widgets/enquiry_type_radio.dart';

class CreateEnquiryScreen extends StatelessWidget {
  const CreateEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContextMenuAppBar(
        title: kPostEnquiry,
        actionButton: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                color: white,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [Text(kEnquiryType), EnquiryTypeRadio()],
      )),
    );
  }
}
