import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';

import '../widgets/kyc_form_page.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key, required this.profileEntity});
  final ProfileEntity profileEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: ContextMenuAppBar(title: kCompleteProfile.tr()),
      body: KycFormPage(profileEntity: profileEntity),
    );
  }
}
