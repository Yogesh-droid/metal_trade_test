import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/news/ui/controllers/news_filter_status_cubit/news_filter_status_cubit.dart';

Map<String, String> filterStatus = {
  "Steel rebar": "rb",
  "Steel wire rod": "wr",
  "Hot rolled coil": "hc",
  "Stainless steel": "ss",
};

class NewsFilterChips extends StatelessWidget {
  const NewsFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = context.read<NewsBloc>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.065,
      child: BlocBuilder<NewsFilterStatusCubit, NewsFilterStatusState>(
        builder: (context, state) {
          if (state is NewsFilterStatusUpdate) {
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: filterStatus.keys
                  .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                          backgroundColor: const Color(0xFFE8DEF8),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(e),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              color: state.status == filterStatus[e]!
                                  ? Colors.white
                                  : null),
                          selected:
                              state.status == filterStatus[e]! ? true : false,
                          checkmarkColor: state.status == filterStatus[e]!
                              ? Colors.white
                              : null,
                          onSelected: (value) {
                            context
                                .read<NewsFilterStatusCubit>()
                                .addFilter(filterStatus[e]!);
                            newsBloc.add(GetAllNewsEvent(
                                page: 0,
                                filters: context
                                    .read<NewsFilterStatusCubit>()
                                    .status));
                          })))
                  .toList(),
            );
          }
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: filterStatus.keys
                .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                        disabledColor: Theme.of(context).colorScheme.tertiary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        label: Text(e),
                        selected: false,
                        onSelected: (value) {
                          context
                              .read<NewsFilterStatusCubit>()
                              .addFilter(filterStatus[e]!);
                          newsBloc.add(GetAllNewsEvent(
                              page: 0,
                              filters: context
                                  .read<NewsFilterStatusCubit>()
                                  .status));
                        })))
                .toList(),
          );
        },
      ),
    );
  }
}
