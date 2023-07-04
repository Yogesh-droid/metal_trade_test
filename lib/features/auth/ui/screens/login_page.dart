import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/assets.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/auth/data/models/country_code_model.dart';
import 'package:metaltrade/features/auth/ui/controllers/country_code_controller.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/auth/ui/widgets/app_web_pages.dart';
import 'package:metaltrade/features/auth/ui/widgets/country_code_picker.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNoController = TextEditingController();
  final List<CountryCodeModel> _countryList = [];
  CountryCodeModel? currentCountryModel;

  @override
  void initState() {
    loadCountries().then((value) => context
        .read<CountryCodeController>()
        .changeCountryCode(currentCountryModel!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: appWidgetGap * 1.5),
            Image.asset(
              Assets.assetsWelcomeAppLogo,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: appWidgetGap),
            const Text(kWhatsYourNo, style: secMed14),
            const SizedBox(height: appWidgetGap),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(appPadding),
                  child: Text(kEnterMobNo, style: secMed11),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  BlocBuilder<CountryCodeController, CountryCodeModel>(
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface))),
                        child: InkWell(
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                pageBuilder: (ctx, a1, a2) {
                                  return const SizedBox();
                                },
                                transitionBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return Transform.scale(
                                      scale: Curves.easeIn
                                          .transform(animation.value),
                                      child: CountryCodePicker(
                                        countryList: _countryList,
                                      ));
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 500));
                          },
                          child: SizedBox(
                            height: 50,
                            child: state.dialCode != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            "${state.emoji}  ${state.dialCode ?? ''}")
                                      ],
                                    ),
                                  )
                                : const Icon(Icons.flag_circle_rounded),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enableIMEPersonalizedLearning: true,
                    enableSuggestions: true,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    controller: phoneNoController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  ))
                ],
              ),
            ),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: BlocBuilder<CountryCodeController, CountryCodeModel>(
                builder: (context, state) {
                  return GetStartedBtn(
                      height: 50,
                      title: kContinue.toUpperCase(),
                      onPressed: () {
                        if (state.dialCode != null) {
                          if (state.dialCode!.isEmpty) {
                            showSnackBar(context, "Enter correct country code");
                          } else {
                            context.read<LoginBloc>().add(GetOtpEvent(
                                mobNo:
                                    "${state.dialCode}${phoneNoController.text}"));
                            context.pushNamed(
                              otpPageName,
                            );
                          }
                        } else {
                          showSnackBar(
                              context, "Please enter corrrect country code");
                        }
                      });
                },
              ),
            ),
            const SizedBox(height: appWidgetGap),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: kAcceptPrivacyNpolicy,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AppWebPages(
                                          url: "https://flutter.dev/")));
                            },
                          text: "\n$kTnC",
                          style: const TextStyle(color: Colors.blue))
                    ]))
          ],
        )),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> loadCountries() async {
    String json = await rootBundle.loadString('assets/country.json');
    List map = jsonDecode(json);
    for (var element in map) {
      _countryList.add(CountryCodeModel.fromJson(element));
    }

    String countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? '';

    currentCountryModel = _countryList
        .where((element) => element.code == countryCode)
        .toList()[0];
  }
}
