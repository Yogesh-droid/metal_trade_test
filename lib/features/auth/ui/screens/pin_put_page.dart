import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../controllers/login_bloc/login_bloc.dart';
import '../controllers/validate_otp/validate_otp_bloc.dart';

class PinPutPage extends StatefulWidget {
  const PinPutPage({super.key});

  @override
  State<PinPutPage> createState() => _PinPutPageState();
}

class _PinPutPageState extends State<PinPutPage> {
  final pinTextController = TextEditingController();
  String phoneNo = '';
  String otp = '';
  late Timer timer;
  int start = 60;
  bool showResendBtn = false;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      start = start - 1;
      setState(() {});
      if (start == 0) {
        timer.cancel();
        showResendBtn = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: appWidgetGap * 1.5),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Text(kOtpVerification,
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$kEnterOtp $phoneNo", style: secMed14),
            ),
            const SizedBox(height: appWidgetGap),
            Align(
              alignment: Alignment.center,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccessfulState) {
                    phoneNo = state.mobNo;
                    otp = state.otp;
                    pinTextController.text = state.otp;
                  }
                  return Pinput(
                    controller: pinTextController,
                    length: 4,
                    // onCompleted: (pin) => context
                    //     .read<ValidateOtpBloc>()
                    //     .add(GetValidateOtpEvent(phoneNo: phoneNo, otp: otp)),
                  );
                },
              ),
            ),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Align(
                alignment: Alignment.center,
                child: BlocConsumer<ValidateOtpBloc, ValidateOtpState>(
                  listener: (context, state) async {
                    if (state is ValidateOtpSuccess) {
                      await LocalStorage.instance
                          .saveToken(state.token)
                          .then((value) {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          context
                              .read<ProfileBloc>()
                              .add(GetUserProfileEvent());
                          context.push(dashBoardRoute);
                        });
                      });
                    }
                  },
                  builder: (context, state) {
                    return FilledButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          context.read<ValidateOtpBloc>().add(
                              GetValidateOtpEvent(phoneNo: phoneNo, otp: otp));
                        },
                        title: kVerify);
                  },
                ),
              ),
            ),
            if (!showResendBtn)
              Align(
                  alignment: Alignment.center,
                  child: Text("Resend OTP in $start seconds"))
            else
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   const Text("Didn't received code ?"),
              //   TextButton(
              //       onPressed: () {
              //         context
              //             .read<LoginBloc>()
              //             .add(GetOtpEvent(mobNo: phoneNo));
              //       },
              //       child: const Text("Resend"))
              // ]),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Didn't received code ? Resend via",
                      style: secMed12.copyWith(color: Colors.grey)),
                  TextSpan(
                      text: " SMS ",
                      style: secMed15.copyWith(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<LoginBloc>()
                              .add(GetOtpEvent(mobNo: phoneNo, via: 'sms'));
                        }),
                  TextSpan(
                      text: " OR ",
                      style: secMed12.copyWith(color: Colors.grey)),
                  TextSpan(
                      text: " WhatsApp ",
                      style: secMed15.copyWith(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<LoginBloc>().add(
                              GetOtpEvent(mobNo: phoneNo, via: 'whatsapp'));
                        })
                ])),
              ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
