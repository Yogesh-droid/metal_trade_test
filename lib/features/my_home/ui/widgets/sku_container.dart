import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/get_sku/get_sku_bloc.dart';

class SkuContainer extends StatelessWidget {
  const SkuContainer({super.key, required this.onSelected});
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSkuBloc, GetSkuState>(builder: (context, state) {
      if (state is AllSkuFetched) {
        return Wrap(
            children: state.skuList
                .map((e) => ChoiceChip(
                      label: Text(e.title ?? ''),
                      selected: false,
                      onSelected: (_) {
                        onSelected((e.title ?? ''));
                      },
                    ))
                .toList());
      } else {
        return const SizedBox();
      }
    });
  }
}
