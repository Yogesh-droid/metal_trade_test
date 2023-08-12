import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../../core/routes/routes.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(kCompleteKyc.tr(),
                          style: secMed20.copyWith(
                              color: Theme.of(context).colorScheme.scrim,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold))
                      .tr(),
                ),
                const Divider(),
                Text(kMtNeedsKyc.tr(),
                        style: secMed15.copyWith(fontFamily: 'Nunito'))
                    .tr(),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  FilledButtonWidget(
                      title: kYesContinue.tr(),
                      onPressed: () {
                        context.pushNamed(kycPageName, extra: ProfileEntity());
                      }),
                  const SizedBox(width: appWidgetGap),
                  OutlinedButtonWidget(
                      title: kMayBeLater.tr(),
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(LogoutUserProfileEvent());
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
