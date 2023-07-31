import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';

import '../../../../core/constants/validator_mixin.dart';

class AddMemberWidget extends StatelessWidget with InputValidationMixin {
  const AddMemberWidget({super.key, required this.onSendClick});
  final Function(String) onSendClick;

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNoFieldController =
        TextEditingController();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        color: Colors.white,
        padding: const EdgeInsets.all(appPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(kAddYourMember,
              style: secMed14.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: appPadding),
          const Divider(),
          const SizedBox(height: appPadding),
          BorderedTextField(
            isObscureText: false,
            hintText: kPhoneNo,
            textEditingController: phoneNoFieldController,
            onValidate: (value) {
              if (isMobileValid(value ?? '')) {
                return null;
              } else {
                return "Please enter correct phone no";
              }
            },
            suffix: IconButton(
                onPressed: () {
                  if (phoneNoFieldController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("please enter mobile no")));
                    return;
                  } else {
                    onSendClick(phoneNoFieldController.text);
                  }
                },
                icon: const Icon(Icons.send_outlined)),
          )
        ]),
      ),
    );
  }
}
