import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/my_home/data/models/sku_model.dart';

import '../controllers/get_sku/get_sku_bloc.dart';

class SkuContainer extends StatelessWidget {
  const SkuContainer({super.key, required this.onSelected});
  final Function(Content) onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kChooseProduct,
                style: secMed14.copyWith(fontWeight: FontWeight.w700)),
            const Divider(),
            BlocBuilder<GetSkuBloc, GetSkuState>(builder: (context, state) {
              if (state is AllSkuFetched) {
                return Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: state.skuList
                        .map((e) => ChoiceChip(
                              backgroundColor: const Color(0xFFE8DEF8),
                              label: Text(e.title ?? ''),
                              selected: false,
                              onSelected: (_) {
                                onSelected((e));
                              },
                            ))
                        .toList());
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
