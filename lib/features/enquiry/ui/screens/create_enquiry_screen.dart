import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/enquiry/ui/widgets/enquiry_type_radio.dart';
import '../controllers/get_sku/get_sku_bloc.dart';
import '../widgets/add_item_container.dart';

class CreateEnquiryScreen extends StatefulWidget {
  const CreateEnquiryScreen({super.key});

  @override
  State<CreateEnquiryScreen> createState() => _CreateEnquiryScreenState();
}

class _CreateEnquiryScreenState extends State<CreateEnquiryScreen> {
  final TextEditingController cityTextController = TextEditingController();
  @override
  void initState() {
    context.read<GetSkuBloc>().add(GetAllSkuEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(kEnquiryType),
            const EnquiryTypeRadio(),
            const SizedBox(height: appPadding),
            const Text(kChooseCity),
            TextFormField(
              controller: cityTextController,
              decoration: const InputDecoration(hintText: "Enter Your City"),
            ),
            const SizedBox(height: appPadding),
            const Text(kItemList),
            const SizedBox(height: appPadding),
            BlocBuilder<GetSkuBloc, GetSkuState>(
              builder: (context, state) {
                if (state is AllSkuFetched) {
                  return ItemListContainer(skuList: state.skuList);
                }
                return const ItemListContainer(skuList: []);
              },
            )
          ],
        ),
      )),
    );
  }
}
