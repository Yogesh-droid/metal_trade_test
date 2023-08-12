import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/auth/ui/controllers/country_code_controller.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';

import '../../../../core/constants/validator_mixin.dart';
import '../../../auth/data/models/country_code_model.dart';
import '../../../auth/ui/screens/login_page.dart';
import '../../../auth/ui/widgets/country_chooser_iconbtn.dart';
import '../controllers/add_member_cubit/add_member_cubit.dart';

class AddMemberWidget extends StatelessWidget with InputValidationMixin {
  const AddMemberWidget(
      {super.key,
      required this.onSendClick,
      required this.textEditingController});
  final Function(String phone) onSendClick;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final AddMemberCubit addMemberCubit = context.read<AddMemberCubit>();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 500,
        color: Colors.white,
        padding: const EdgeInsets.all(appPadding * 2),
        child: SingleChildScrollView(
          child: BlocBuilder<AddMemberCubit, AddMemberState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kAddYourMember,
                            style:
                                secMed14.copyWith(fontWeight: FontWeight.w700))
                        .tr(),
                    const SizedBox(height: appPadding),
                    const Divider(),
                    const SizedBox(height: appPadding),
                    BlocBuilder<CountryCodeController, CountryCodeModel>(
                      builder: (context, countryCodeModel) {
                        return BorderedTextField(
                          isObscureText: false,
                          hintText: kPhoneNo,
                          textEditingController: textEditingController,
                          textInputType: TextInputType.phone,
                          prefix:
                              CountryChooserIconBtn(countryList: countryList),
                          suffix: IconButton(
                              onPressed: () {
                                if (textEditingController.text.isNotEmpty) {
                                  if (addMemberCubit.allEmployeeList.any(
                                      (element) =>
                                          element.mobileNumber ==
                                          "${countryCodeModel.dialCode}${textEditingController.text}")) {
                                    Fluttertoast.showToast(
                                        msg: "This member is already added",
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        gravity: ToastGravity.CENTER,
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .scrim);
                                  } else {
                                    onSendClick(
                                        "${countryCodeModel.dialCode}${textEditingController.text}");
                                    textEditingController.clear();
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter mobile no.",
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      gravity: ToastGravity.CENTER,
                                      textColor:
                                          Theme.of(context).colorScheme.scrim);
                                }
                              },
                              icon: const Icon(Icons.send_outlined)),
                        );
                      },
                    ),
                    ...addMemberCubit.allEmployeeList.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 50,
                            padding:
                                const EdgeInsets.only(left: appPadding * 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.mobileNumber ?? ''),
                                  BlocBuilder<AddMemberCubit, AddMemberState>(
                                    builder: (context, state) {
                                      if (state is DeletingEmp) {
                                        return state.mobileNo == e.mobileNumber
                                            ? const CircularProgressIndicator()
                                            : const SizedBox.shrink();
                                      } else {
                                        return IconButton(
                                            onPressed: () {
                                              addMemberCubit.deleteEmp(
                                                  e.mobileNumber ?? '');
                                            },
                                            icon: const Icon(
                                                CupertinoIcons.delete));
                                      }
                                    },
                                  )
                                ]),
                          ),
                        ))
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
