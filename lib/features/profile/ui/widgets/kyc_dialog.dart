import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';

class KycDialog extends StatelessWidget {
  const KycDialog({super.key, required this.profileEntity});
  final ProfileEntity profileEntity;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(appPadding),
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  size: 60,
                ),
                const Text(
                  kPleaseCompleteKyc,
                  style: secMed18,
                  textAlign: TextAlign.center,
                ),
                GetStartedBtn(
                    title: kCompleteKyc,
                    onPressed: () {
                      context.pushNamed(kycPageName);
                    }),
              ],
            )),
      ),
    );
  }
}
