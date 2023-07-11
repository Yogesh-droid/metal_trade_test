import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_form.dart';
import '../controllers/get_sku/get_sku_bloc.dart';

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
    return const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(appPadding), child: CreateEnquiryForm()));
  }
}
