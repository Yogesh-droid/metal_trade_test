import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';

// ignore: constant_identifier_names
enum EnquiryStatus { Inreview, Active, Complete }

class QuoteFilters extends StatelessWidget {
  const QuoteFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final MyQuoteBloc myQuoteBloc = context.read<MyQuoteBloc>();
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      height: MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<QuoteFilterCubit, QuoteFilterState>(
        builder: (context, state) {
          if (state is FilterStatusUpdate) {
            return ListView(
              padding: const EdgeInsets.only(left: appPadding),
              scrollDirection: Axis.horizontal,
              children: EnquiryStatus.values
                  .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                          backgroundColor: const Color(0xFFE8DEF8),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(e.name),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: state.statusList.contains(e.name)
                                  ? Colors.white
                                  : null),
                          selected: state.statusList.contains(e.name),
                          checkmarkColor: state.statusList.contains(e.name)
                              ? Colors.white
                              : null,
                          onSelected: (value) {
                            myQuoteBloc.add(GetQuoteList(
                                isLoadMore: false,
                                page: 0,
                                status: state.statusList));
                            context.read<QuoteFilterCubit>().addFilter(
                                e.name == "Complete"
                                    ? ["Complete", "Expired", "Closed"]
                                    : [e.name]);
                          })))
                  .toList(),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(left: appPadding),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: EnquiryStatus.values
                .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                        backgroundColor: const Color(0xFFE8DEF8),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        label: Text(e.name),
                        selected: false,
                        onSelected: (value) {
                          myQuoteBloc.add(GetQuoteList(
                              page: 0,
                              isLoadMore: false,
                              status: e.name == "Complete"
                                  ? ["Complete", "Expired", "Closed"]
                                  : [e.name]));
                          context.read<QuoteFilterCubit>().addFilter(
                              e.name == "Complete"
                                  ? ["Complete", "Expired", "Closed"]
                                  : [e.name]);
                        })))
                .toList(),
          );
        },
      ),
    );
  }
}
