import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/my_home/data/models/post_enquiry_req_model.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/controllers/submit_quote/submit_quote_bloc.dart';
import 'package:metaltrade/features/rfq/ui/widgets/item_container.dart';
import 'package:metaltrade/features/rfq/ui/widgets/total_price_box.dart';

class SubmitQuoteScreen extends StatefulWidget {
  const SubmitQuoteScreen({super.key, required this.content});
  final Content content;

  @override
  State<SubmitQuoteScreen> createState() => _SubmitQuoteScreenState();
}

class _SubmitQuoteScreenState extends State<SubmitQuoteScreen> {
  late Content content;
  List<int> selectedIndex = [];
  double totalPrice = 0;
  late SubmitQuoteBloc submitQuoteBloc;

  @override
  void initState() {
    submitQuoteBloc = context.read<SubmitQuoteBloc>();
    content = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContextMenuAppBar(title: kSubmitQuote, subtitle: content.uuid),
      body: SingleChildScrollView(
        child: _buildPanel(),
      ),
      floatingActionButton: selectedIndex.isNotEmpty
          ? BlocListener<SubmitQuoteBloc, SubmitQuoteState>(
              listener: (context, state) {
                if (state is SubmitQuoteSuccessful) {
                  context.read<MyQuoteBloc>().add(GetQuoteList(
                      page: 0, status: const [], isLoadMore: false));
                  context.pushNamed(myQuotePageScreenName);
                }
              },
              child: TotalPriceBox(
                  onPressed: () {
                    List<Map<String, dynamic>> selectedItems = [];
                    Map<String, dynamic> submitQuote = {};
                    for (var element in content.item!) {
                      if (selectedIndex.contains(element.id)) {
                        selectedItems.add({
                          "quantity": element.quantity,
                          "quantityUnit": element.quantityUnit,
                          "price": element.price,
                          "remarks": element.remarks,
                          "sku": {"id": element.sku!.id}
                        });
                      }
                      submitQuote['transportationTerms'] =
                          content.transportationTerms;
                      submitQuote['paymentTerms'] = content.paymentTerms;
                      submitQuote['deliveryTerms'] = content.deliveryTerms;
                      submitQuote['item'] = selectedItems;
                    }
                    final PostEnquiryModel postEnquiryModel =
                        PostEnquiryModel.fromJson(submitQuote);

                    submitQuoteBloc.add(SubmitQuote(
                        postEnquiryModel: postEnquiryModel,
                        quoteId: content.id!));
                  },
                  price: totalPrice),
            )
          : const SizedBox(),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: content.item!
          .map((e) => AnimatedSize(
                duration: const Duration(milliseconds: 500),
                child: selectedIndex.contains(e.id)
                    ? ItemContainer(
                        item: e,
                        onPriceChange: (value) {
                          if (value.isNotEmpty) {
                            content.item!
                                .where((element) => element.id == e.id)
                                .first
                                .price = double.parse(value);
                            totalPrice += double.parse(value);
                            setState(() {});
                          }
                        },
                        onQuantityChange: (value) {
                          content.item!
                              .where((element) => element.id == e.id)
                              .first
                              .quantity = int.parse(value);
                        },
                        onChange: (value) {
                          setState(() {
                            selectedIndex.contains(e.id)
                                ? selectedIndex.remove(e.id)
                                : selectedIndex.add(e.id!);
                            totalPrice -= (e.price! * e.quantity!);
                          });
                        })
                    : CheckboxListTile(
                        title: Text(e.sku!.title ?? '',
                            style:
                                secMed14.copyWith(fontWeight: FontWeight.w700)),
                        subtitle: Text(
                          e.remarks ?? '',
                          style: secMed12.copyWith(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex.contains(e.id)
                                ? selectedIndex.remove(e.id)
                                : selectedIndex.add(e.id!);
                            totalPrice += (e.price! * e.quantity!);
                          });
                        }),
              ))
          .toList(),
    );
  }
}
