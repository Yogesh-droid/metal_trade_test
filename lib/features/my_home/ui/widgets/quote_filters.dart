import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';

// ignore: constant_identifier_names
enum EnquiryStatus { Inreview, Active, Complete }

class QuoteFilters extends StatelessWidget {
  const QuoteFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final MyQuoteBloc myQuoteBloc = context.read<MyQuoteBloc>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.065,
      child: BlocBuilder<QuoteFilterCubit, QuoteFilterState>(
        builder: (context, state) {
          if (state is FilterStatusUpdate) {
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: EnquiryStatus.values
                  .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                          disabledColor: Theme.of(context).colorScheme.tertiary,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(e.name),
                          selected: state.statusList.contains(e.name),
                          onSelected: (value) {
                            myQuoteBloc.add(GetQuoteList(
                                page: 0, status: state.statusList));
                            context.read<QuoteFilterCubit>().addFilter(e.name);
                          })))
                  .toList(),
            );
          }
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: EnquiryStatus.values
                .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                        disabledColor: Theme.of(context).colorScheme.tertiary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        label: Text(e.name),
                        selected: false,
                        onSelected: (value) {
                          myQuoteBloc
                              .add(GetQuoteList(page: 0, status: [e.name]));
                          context.read<QuoteFilterCubit>().addFilter(e.name);
                        })))
                .toList(),
          );
        },
      ),
    );
  }
}