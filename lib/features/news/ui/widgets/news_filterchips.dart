import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/news/ui/controllers/news_filter_status_cubit/news_filter_status_cubit.dart';

Map<String, String> filterStatus = {
  "Steel wire rod": "wr",
  "Steel rebar": "rb",
  "Hot rolled coil": "hc",
  "Stainless steel": "ss",
  "All": "wr,rb,hc,ss"
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
                          disabledColor: Theme.of(context).colorScheme.tertiary,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(e),
                          selected: state.statusList.contains(filterStatus[e]!),
                          onSelected: (value) {
                            context
                                .read<NewsFilterStatusCubit>()
                                .addFilter(filterStatus[e]!);
                            newsBloc.add(GetAllNewsEvent(
                                page: 0,
                                filters: context
                                    .read<NewsFilterStatusCubit>()
                                    .statusList));
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
                                  .statusList));
                        })))
                .toList(),
          );
        },
      ),
    );
  }
}
