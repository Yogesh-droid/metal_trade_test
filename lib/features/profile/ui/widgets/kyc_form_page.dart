import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/constants/validator_mixin.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/profile/data/models/kyc_request_model.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/ui/controllers/country_cubit/country_cubit.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import '../../../../core/constants/spaces.dart';

class KycFormPage extends StatefulWidget {
  const KycFormPage({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  State<KycFormPage> createState() => _KycFormPageState();
}

class _KycFormPageState extends State<KycFormPage> with InputValidationMixin {
  late CountryCubit countryCubit;
  late ProfileBloc profileBloc;
  late ProfileEntity profileEntity;
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();

  final addressController = TextEditingController();
  final addressFocus = FocusNode();

  final companyNameController = TextEditingController();
  final companyNameFocus = FocusNode();

  final representativeNameController = TextEditingController();
  final representativeNameFocus = FocusNode();

  final pinController = TextEditingController();
  final pinFocus = FocusNode();

  int? selectedCountry;
  final countryFocus = FocusNode();

  @override
  void initState() {
    countryCubit = context.read<CountryCubit>();
    profileBloc = context.read<ProfileBloc>();
    if (countryCubit.state is CountryInitial) {
      countryCubit.getCountries();
    }
    context.read<KycBloc>().stream.listen((state) {
      if (state is KycDoneState) {
        onKycDone(context);
      } else if (state is KycFailedState) {
        onKycFailed(state.exception, context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Form(
        key: KycFormPage._formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            BorderedTextField(
              isObscureText: false,
              hintText: kCompanyName,
              textEditingController: companyNameController,
              focusNode: companyNameFocus,
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                representativeNameFocus.requestFocus();
              },
              onValidate: (value) {
                if (isNameValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid Company Name';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            BorderedTextField(
              isObscureText: false,
              hintText: kRepresentativeName,
              textEditingController: representativeNameController,
              textInputType: TextInputType.name,
              focusNode: representativeNameFocus,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                emailFocus.requestFocus();
              },
              onValidate: (value) {
                if (isNameValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid Name';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            BorderedTextField(
              isObscureText: false,
              hintText: kEmail,
              textEditingController: emailController,
              textInputType: TextInputType.emailAddress,
              focusNode: emailFocus,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                phoneFocus.requestFocus();
              },
              onValidate: (value) {
                if (isEmailValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid email';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            BorderedTextField(
              isObscureText: false,
              textInputType: TextInputType.phone,
              hintText: kPhoneNo,
              focusNode: phoneFocus,
              textEditingController: phoneController,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                addressFocus.requestFocus();
              },
              onValidate: (value) {
                if (isMobileValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid mobile no';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            BorderedTextField(
              isObscureText: false,
              hintText: kAddress,
              textEditingController: addressController,
              focusNode: addressFocus,
              textInputType: TextInputType.streetAddress,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                pinFocus.requestFocus();
              },
              onValidate: (value) {
                if (isNameValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid Address';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            BorderedTextField(
              isObscureText: false,
              hintText: kPinCode,
              textEditingController: pinController,
              focusNode: pinFocus,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onDone: (value) {
                countryFocus.requestFocus();
              },
              onValidate: (value) {
                if (isPinValid(value!)) {
                  return null;
                } else {
                  return 'Enter valid Pin';
                }
              },
            ),
            const SizedBox(height: appFormFieldGap),
            countryDropDown(),
            const SizedBox(height: appFormFieldGap),
            GetStartedBtn(
                title: kSubmit,
                onPressed: () {
                  if (KycFormPage._formKey.currentState!.validate()) {
                    context.read<KycBloc>().add(DoKycEvent(KycRequestModel(
                        id: profileBloc.profileEntity!.id,
                        address: addressController.text,
                        companyNumber: phoneController.text,
                        email: emailController.text,
                        legalRepresentativeName:
                            representativeNameController.text,
                        name: companyNameController.text,
                        country: Country(id: selectedCountry),
                        pinCode: pinController.text)));
                  }
                },
                width: MediaQuery.of(context).size.width / 1.5)
          ]),
        ),
      ),
    );
  }

  Widget countryDropDown() {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountrySuccess) {
          return DropdownButtonFormField<int>(
              focusNode: countryFocus,
              validator: (value) {
                if (value != null) {
                  if (isNameValid(value.toString())) {
                    return null;
                  } else {
                    return 'Please Choose Your Country';
                  }
                } else {
                  return 'Please Choose Your Country';
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(appPadding),
                    gapPadding: 8),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(appPadding),
                    gapPadding: 8),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(appPadding),
                    gapPadding: 8),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(appPadding),
                    gapPadding: 8),
                labelText: kChooseCountry,
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              items: state.countries
                  .map((e) =>
                      DropdownMenuItem(value: e.id, child: Text(e.name ?? '')))
                  .toList(),
              onChanged: (value) {
                selectedCountry = value;
              });
        } else {
          return const SizedBox(
            child: Center(child: Text("Sorry No countries found")),
          );
        }
      },
    );
  }

  void onKycDone(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                "Congratulation! KYC is done",
                style: secMed15.copyWith(fontWeight: FontWeight.w700),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(kBack)),
                TextButton(
                    onPressed: () {
                      context.pop();
                      context.pushReplacementNamed(profilePageName);
                    },
                    child: const Text(kMyProfile))
              ],
            ));
  }

  void onKycFailed(Exception exception, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                exception.toString(),
                style: secMed15.copyWith(fontWeight: FontWeight.w700),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(kCancel)),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(kRetry))
              ],
            ));
  }
}
