import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';

// ignore: constant_identifier_names
enum EnquiryStatus { Inreview, Active, Complete }

class FilterChipList extends StatelessWidget {
  const FilterChipList({super.key});

  @override
  Widget build(BuildContext context) {
    final MyRfqBloc myRfqBloc = context.read<MyRfqBloc>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.065,
      child: BlocBuilder<FilterStatusCubit, FilterStatusState>(
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
                            myRfqBloc.add(GetMyRfqList(
                                page: 0, status: state.statusList));
                            context.read<FilterStatusCubit>().addFilter(e.name);
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
                          context.read<FilterStatusCubit>().addFilter(e.name);
                        })))
                .toList(),
          );
        },
      ),
    );
  }
}
