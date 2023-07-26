import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/landing/ui/widgets/web/need_more_info_tc.dart';

import '../../../../../core/constants/text_tyles.dart';

class NeedMoreInfoWidget extends StatelessWidget {
  const NeedMoreInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final contactNoController = TextEditingController();
    final additionalMsgController = TextEditingController();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          Text(kNeedMoreInfo,
              style: secMed36.copyWith(
                  fontWeight: FontWeight.w700, fontFamily: "Nunito")),
          Row(
            children: [
              Expanded(
                  child: NeedMoreInfoTc(
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                      onChange: (value) {},
                      hint: kRepresentativeName,
                      textEditingController: nameController)),
              const SizedBox(width: appWidgetGap),
              Expanded(
                  child: NeedMoreInfoTc(
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Contact";
                        }
                        return null;
                      },
                      onChange: (value) {},
                      hint: kPhoneNo,
                      textEditingController: contactNoController))
            ],
          ),
          const SizedBox(height: appWidgetGap),
          NeedMoreInfoTc(
              onValidate: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Your Contact";
                }
                return null;
              },
              onChange: (value) {},
              hint: kAdditionalInfo,
              textEditingController: additionalMsgController),
          const SizedBox(height: appWidgetGap),
          FilledButtonWidget(
            title: kSubmit,
            onPressed: () {},
            width: MediaQuery.of(context).size.width / 2,
          )
        ],
      ),
    );
  }
}
