import 'package:flutter/widgets.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

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
            width: 60,
            child: const Text(kTopNews, style: secMed14),
          ),
          Expanded(
            child: ListView(
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                children: news
                    .map((e) => SizedBox(
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
