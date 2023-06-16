import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/assets.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/auth/data/models/country_code_model.dart';
import 'package:metaltrade/features/auth/ui/controllers/country_code_controller.dart';
import 'package:metaltrade/features/auth/ui/widgets/app_web_pages.dart';
import 'package:metaltrade/features/auth/ui/widgets/country_code_picker.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import '../../../../core/constants/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
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
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: black))),
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
                                      child: const CountryCodePicker());
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
                                : const Icon(Icons.flag_circle_rounded,
                                    color: blue),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: TextFormField(
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
              child: GetStartedBtn(
                  height: 50,
                  title: kContinue.toUpperCase(),
                  onPressed: () {
                    context.pushNamed(
                      otpPageName,
                      queryParams: {"otp": "123456"},
                    );
                  }),
            ),
            const SizedBox(height: appWidgetGap),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: kAcceptPrivacyNpolicy,
                    style: const TextStyle(color: black),
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
}
