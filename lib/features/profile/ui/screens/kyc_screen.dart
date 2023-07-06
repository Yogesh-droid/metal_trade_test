import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';

import '../widgets/kyc_form_page.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ContextMenuAppBar(title: kCompleteKyc),
      body: KycFormPage(),
    );
  }
}