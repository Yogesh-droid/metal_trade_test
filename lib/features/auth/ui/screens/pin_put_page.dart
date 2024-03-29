import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../../core/resource/request_params/request_params.dart';
import '../../../../core/routes/routes.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../controllers/login_bloc/login_bloc.dart';
import '../controllers/validate_otp/validate_otp_bloc.dart';

class PinPutPage extends StatefulWidget {
  const PinPutPage({super.key, required this.phoneNo});
  final String phoneNo;

  @override
  State<PinPutPage> createState() => _PinPutPageState();
}

class _PinPutPageState extends State<PinPutPage> {
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  late Timer timer;
  int start = 60;
  String pinReceived = '';
  bool showResendBtn = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initInteractor();
      controller = OTPTextEditController(
        codeLength: 5,
        onCodeReceive: (code) =>
            debugPrint('Your Application receive code - $code'),
        otpInteractor: _otpInteractor,
      )..startListenUserConsent(
          (code) {
            final exp = RegExp(r'(\d{4})');
            return exp.stringMatch(code ?? '') ?? '';
          },
          strategies: [
            SampleStrategy(),
          ],
        );
    } else {
      controller = OTPTextEditController(codeLength: 4);
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      start = start - 1;
      setState(() {});
      if (start == 0) {
        timer.cancel();
        showResendBtn = true;
        setState(() {});
      }
    });
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  @override
  void dispose() {
    timer.cancel();
    controller.stopListen();
    super.dispose();
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
              padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
              child: Text(kOtpVerification,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700))
                  .tr(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: appPadding * 2, vertical: appPadding),
              child: Text("${kEnterOtp.tr()} ${widget.phoneNo}",
                      style: secMed14.copyWith(
                          fontFamily: "Nunito",
                          color: Theme.of(context).colorScheme.outline))
                  .tr(),
            ),
            const SizedBox(height: appWidgetGap),
            Align(
                alignment: Alignment.center,
                child: Pinput(
                    controller: controller,
                    length: 4,
                    onCompleted: (pin) {
                      pinReceived = pin;
                      context.read<ValidateOtpBloc>().add(GetValidateOtpEvent(
                          phoneNo: widget.phoneNo, otp: pin));
                    })),
            const SizedBox(height: appWidgetGap / 2),
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
                        header = {
                          "Authorization":
                              "Bearer ${LocalStorage.instance.token}",
                          "Content-Type": "application/json"
                        };
                        Future.delayed(const Duration(milliseconds: 200), () {
                          context
                              .read<ProfileBloc>()
                              .add(GetUserProfileEvent());
                          context.go(dashBoardRoute);
                        });
                      });
                    } else if (state is ValidateOtpFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Validation Error : ${state.exception}')));
                    }
                  },
                  builder: (context, state) {
                    return FilledButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          context.read<ValidateOtpBloc>().add(
                              GetValidateOtpEvent(
                                  phoneNo: widget.phoneNo, otp: pinReceived));
                        },
                        title: kVerify.tr());
                  },
                ),
              ),
            ),
            if (!showResendBtn)
              Align(
                  alignment: Alignment.center,
                  child: Text("Resend OTP in $start seconds"))
            else
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Didn't received code ? Resend via",
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.outline)),
                  TextSpan(
                      text: " SMS ",
                      style: secMed15.copyWith(color: Colors.indigo),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<LoginBloc>()
                              .add(GetOtpEvent(mobNo: 'phoneNo', via: 'sms'));
                        }),
                  TextSpan(
                      text: " OR ",
                      style: secMed12.copyWith(color: Colors.grey)),
                  TextSpan(
                      text: " WhatsApp ",
                      style: secMed15.copyWith(color: Colors.indigo),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<LoginBloc>().add(
                              GetOtpEvent(mobNo: 'phoneNo', via: 'whatsapp'));
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

class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 60),
      () => 'No Code received',
    );
  }
}






















/* import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
              child: Text(kOtpVerification,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700))
                  .tr(),
            ),
            // const SizedBox(height: appPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: appPadding * 2, vertical: appPadding),
              child: Text("${kEnterOtp.tr()} $phoneNo",
                      style: secMed14.copyWith(
                          fontFamily: "Nunito",
                          color: Theme.of(context).colorScheme.outline))
                  .tr(),
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
                    onCompleted: (pin) => context
                        .read<ValidateOtpBloc>()
                        .add(GetValidateOtpEvent(phoneNo: phoneNo, otp: otp)),
                  );
                },
              ),
            ),
            const SizedBox(height: appWidgetGap / 2),
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
                        header = {
                          "Authorization":
                              "Bearer ${LocalStorage.instance.token}",
                          "Content-Type": "application/json"
                        };
                        Future.delayed(const Duration(milliseconds: 200), () {
                          context
                              .read<ProfileBloc>()
                              .add(GetUserProfileEvent());
                          context.go(dashBoardRoute);
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
                        title: kVerify.tr());
                  },
                ),
              ),
            ),
            if (!showResendBtn)
              Align(
                  alignment: Alignment.center,
                  child: Text("Resend OTP in $start seconds"))
            else
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Didn't received code ? Resend via",
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.outline)),
                  TextSpan(
                      text: " SMS ",
                      style: secMed15.copyWith(color: Colors.indigo),
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
                      style: secMed15.copyWith(color: Colors.indigo),
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
 */