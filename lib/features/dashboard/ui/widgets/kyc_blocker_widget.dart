import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../../core/routes/routes.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../../../profile/domain/entities/profile_entity.dart';

class KycBlocker extends StatelessWidget {
  const KycBlocker({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Column(
              children: [
                Text(kCompleteKyc,
                    style: secMed20.copyWith(
                        color: Colors.black,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold)),
                Text(kMtNeedsKyc,
                    style: secMed15.copyWith(fontFamily: 'Nunito')),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  FilledButtonWidget(
                      title: kYesContinue,
                      onPressed: () {
                        context.pushNamed(kycPageName, extra: ProfileEntity());
                      }),
                  const SizedBox(width: appWidgetGap),
                  OutlinedButtonWidget(
                      title: kMayBeLater,
                      onPressed: () {
                        SystemNavigator.pop();
                      })
                ]),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ));
  }
}
