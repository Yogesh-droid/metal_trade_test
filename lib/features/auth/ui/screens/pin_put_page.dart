import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../controllers/login_bloc/login_bloc.dart';

class PinPutPage extends StatelessWidget {
  PinPutPage({super.key});
  final pinTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: appWidgetGap * 1.5),
            Image.asset(
              Assets.assetsWelcomeAppLogo,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: appWidgetGap),
            const Text(kEnterOtp, style: secMed14),
            const SizedBox(height: appWidgetGap),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccessfulState) {
                  pinTextController.text = state.otp;
                }
                return Pinput(
                  controller: pinTextController,
                  length: 6,
                  onCompleted: (pin) => print(pin),
                );
              },
            ),
            const SizedBox(height: appWidgetGap),
            Padding(
              padding: const EdgeInsets.all(appPadding),
              child: GetStartedBtn(
                  height: 50,
                  title: kSubmit.toUpperCase(),
                  onPressed: () {
                    context.push(dashBoardRoute);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
