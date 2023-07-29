import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/news/ui/widgets/news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsFetched) {
        if (state.newsList.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            children: state.newsList
                .map((e) => NewsCard(
                      news: e,
                    ))
                .toList(),
          );
        } else {
          return Center(
              child: Text(
            "No new News",
            textAlign: TextAlign.center,
            style: secMed18.copyWith(fontWeight: FontWeight.w700),
          ));
        }
      } else if (state is NewsInitial) {
        return const Center(child: LoadingDots());
      } else if (state is NewsFailed) {
        return Center(child: Text(state.exception.toString()));
      }
      return const Center(child: Text("No Data found"));
    });
  }
}
