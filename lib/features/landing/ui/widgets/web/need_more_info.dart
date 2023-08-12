import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/landing/ui/controllers/cubit/request_callback_cubit.dart';
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
                      fontWeight: FontWeight.w700, fontFamily: "Nunito"))
              .tr(),
          const SizedBox(height: appWidgetGap),
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
              hint: kAdditionalInfo.tr(),
              textEditingController: additionalMsgController),
          const SizedBox(height: appWidgetGap),
          BlocConsumer<RequestCallbackCubit, RequestCallbackState>(
            listener: (context, state) {
              if (state is RequestCallbackSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Request sent Successfully")));
              }
            },
            builder: (context, state) {
              if (state is RequestCallbackLoading) {
                return FilledButtonLoading(
                  width: MediaQuery.of(context).size.width / 4,
                );
              }
              return FilledButtonWidget(
                title: kSubmit.tr(),
                onPressed: () {
                  context.read<RequestCallbackCubit>().requestCallback({
                    "name": nameController.text,
                    "mobileNumber": contactNoController.text,
                    "message": additionalMsgController.text
                  });
                },
                width: MediaQuery.of(context).size.width / 4,
              );
            },
          )
        ],
      ),
    );
  }
}
