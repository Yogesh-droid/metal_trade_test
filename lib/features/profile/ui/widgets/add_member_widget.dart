import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import '../../../../core/constants/validator_mixin.dart';

class AddMemberWidget extends StatelessWidget with InputValidationMixin {
  static final _mobileNoKey = GlobalKey<FormState>();
  const AddMemberWidget(
      {super.key,
      required this.onSendClick,
      required this.textEditingController});
  final Function() onSendClick;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        color: Colors.white,
        padding: const EdgeInsets.all(appPadding * 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(kAddYourMember,
              style: secMed14.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: appPadding),
          const Divider(),
          const SizedBox(height: appPadding),
          Form(
            key: _mobileNoKey,
            child: BorderedTextField(
              isObscureText: false,
              hintText: kPhoneNo,
              textEditingController: textEditingController,
              textInputType: TextInputType.phone,
              onValidate: (value) {
                if (isMobileValid(value ?? '')) {
                  return null;
                } else {
                  return "Please enter correct phone no";
                }
              },
              suffix: IconButton(
                  onPressed: () {
                    if (_mobileNoKey.currentState!.validate()) {
                      onSendClick();
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.send_outlined)),
            ),
          )
        ]),
      ),
    );
  }
}
