import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/auth/data/models/country_code_model.dart';
import 'package:metaltrade/features/auth/ui/controllers/country_code_controller.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/auth/ui/widgets/app_web_pages.dart';
import 'package:metaltrade/features/auth/ui/widgets/country_chooser_iconbtn.dart';
import 'package:metaltrade/features/auth/ui/widgets/filled_text_field.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';

import '../../../../core/constants/text_tyles.dart';

final List<CountryCodeModel> countryList = [];
CountryCodeModel? initialCountryModel;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNoController = TextEditingController();
  // final List<CountryCodeModel> _countryList = [];
  CountryCodeModel? currentCountryModel;

  @override
  void initState() {
    loadCountries().then((value) => context
        .read<CountryCodeController>()
        .changeCountryCode(initialCountryModel!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: appWidgetGap * 1.5),
            const SizedBox(height: appWidgetGap),
            Text(kWhatsYourNo,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: 'Nunito', fontWeight: FontWeight.w700))
                .tr(),
            const SizedBox(height: appWidgetGap / 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledTextFieldWidget(
                textInputType: TextInputType.phone,
                textEditingController: phoneNoController,
                prefix: CountryChooserIconBtn(countryList: countryList),
              ),
            ),
            const SizedBox(height: appWidgetGap / 2),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: BlocBuilder<CountryCodeController, CountryCodeModel>(
                builder: (context, state) {
                  return FilledButtonWidget(
                      width: MediaQuery.of(context).size.width,
                      title: kContinue.tr(),
                      onPressed: () {
                        if (state.dialCode != null) {
                          if (state.dialCode!.isEmpty) {
                            showSnackBar(context, "Enter correct country code");
                          } else {
                            context.read<LoginBloc>().add(GetOtpEvent(
                                mobNo:
                                    "${state.dialCode}${phoneNoController.text}",
                                via: 'sms'));
                            context.pushNamed(
                              otpPageName,
                            );
                          }
                        } else {
                          showSnackBar(context, "Enter correct country code");
                        }
                      });
                },
              ),
            ),
            const SizedBox(height: appWidgetGap / 2),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: kAcceptPrivacyNpolicy.tr(),
                    style: secMed12.copyWith(
                        color: Theme.of(context).colorScheme.outline),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AppWebPages(
                                            url:
                                                "https://metaltrade.io/terms.html",
                                            title: kTermsOfUse,
                                          )));
                            },
                          text: "\n${kTnC.tr()}",
                          style: const TextStyle(color: Colors.blue))
                    ]))
          ],
        ),
      )),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message).tr()));
  }

  Future<void> loadCountries() async {
    String json = await rootBundle.loadString('assets/country.json');
    List map = jsonDecode(json);
    for (var element in map) {
      countryList.add(CountryCodeModel.fromJson(element));
    }

    String countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? '';

    currentCountryModel =
        countryList.where((element) => element.code == countryCode).toList()[0];
    initialCountryModel =
        countryList.where((element) => element.code == countryCode).toList()[0];
  }
}
