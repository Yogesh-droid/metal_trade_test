import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../controllers/login_bloc/login_bloc.dart';
import '../controllers/validate_otp/validate_otp_bloc.dart';

// ignore: must_be_immutable
class PinPutPage extends StatelessWidget {
  PinPutPage({super.key});
  final pinTextController = TextEditingController();
  String phoneNo = '';
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: appWidgetGap * 1.5),
            Image.asset(
              Assets.assetsWelcomeAppIcon,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: appWidgetGap),
            const Text(kEnterOtp, style: secMed14),
            const SizedBox(height: appWidgetGap),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccessfulState) {
                  phoneNo = state.mobNo;
                  otp = state.otp;
                  pinTextController.text = state.otp;
                }
                return Pinput(
                  controller: pinTextController,
                  length: 4,
                  onCompleted: (pin) => debugPrint(pin),
                );
              },
            ),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: BlocConsumer<ValidateOtpBloc, ValidateOtpState>(
                listener: (context, state) {
                  if (state is ValidateOtpSuccess) {
                    LocalStorage.instance.saveToken(state.token);
                    context.push(dashBoardRoute);
                  }
                },
                builder: (context, state) {
                  return FilledButtonWidget(
                      onPressed: () {
                        context.read<ValidateOtpBloc>().add(
                            GetValidateOtpEvent(phoneNo: phoneNo, otp: otp));
                      },
                      title: kSubmit.toUpperCase());
                },
              ),
            ),
            const SizedBox(height: 200)
          ],
        ),
      ),
    );
  }
}
