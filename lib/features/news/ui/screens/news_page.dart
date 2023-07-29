import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/news/ui/controllers/news_filter_status_cubit/news_filter_status_cubit.dart';
import 'package:metaltrade/features/news/ui/widgets/news_filterchips.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import 'news_list.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc newsBloc;
  late ScrollController scrollController;
  late NewsFilterStatusCubit newsFilterStatusCubit;
  bool isLoadMore = false;
  @override
  void initState() {
    newsBloc = context.read<NewsBloc>();
    newsFilterStatusCubit = context.read<NewsFilterStatusCubit>();
    newsFilterStatusCubit.addFilter('rb');
    newsBloc.add(GetAllNewsEvent(page: 0, filters: 'rb'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: appWidgetGap),
          const NewsFilterChips(),
          const Expanded(child: NewsList()),
          if (isLoadMore) const SizedBox(height: 60, child: LoadingDots())
        ],
      ),
    );
  }
}
