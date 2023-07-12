import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/news/ui/widgets/news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsFetched) {
        return ListView(
          shrinkWrap: true,
          controller: scrollController,
          children: state.newsList
              .map((e) => NewsCard(
                    news: e,
                  ))
              .toList(),
        );
      } else if (state is NewsInitial) {
        return const Center(child: LoadingDots());
      } else if (state is NewsFailed) {
        return Center(child: Text(state.exception.toString()));
      }
      return const Center(child: Text("No Data found"));
    });
  }
}
