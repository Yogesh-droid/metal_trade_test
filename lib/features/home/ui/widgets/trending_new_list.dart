import 'package:flutter/widgets.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import '../../../../core/constants/app_colors.dart';

class TrendingNewsList extends StatelessWidget {
  const TrendingNewsList(
      {super.key, required this.scrollController, required this.news});
  final ScrollController scrollController;
  final List<String> news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: blue,
            width: 60,
            child: Text(kTopNews, style: secMed14.copyWith(color: white)),
          ),
          Expanded(
            child: ListView(
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                children: news
                    .map((e) => Container(
                          decoration: const BoxDecoration(color: grey7),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              e,
                              style: secMed15,
                              maxLines: 1,
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
