import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_form.dart';
import '../controllers/get_sku/get_sku_bloc.dart';
import '../widgets/add_item_container.dart';
import '../widgets/enquiry_type_radio.dart';

class CreateEnquiryScreen extends StatefulWidget {
  const CreateEnquiryScreen({super.key});

  @override
  State<CreateEnquiryScreen> createState() => _CreateEnquiryScreenState();
}

class _CreateEnquiryScreenState extends State<CreateEnquiryScreen> {
  @override
  void initState() {
    context.read<GetSkuBloc>().add(GetAllSkuEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: ContextMenuAppBar(
        title: kPostEnquiry,
        actionButton: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.surface,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(appPadding),
              child: CreateEnquiryForm())),
    );
  }
}
