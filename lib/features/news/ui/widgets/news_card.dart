import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/news/data/models/news_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateTime.tryParse(news.lastModifiedDate ?? '') != null
                ? Text(
                    "$kPosted : ${DateFormat('dd MMM yyyy').format(DateTime.tryParse(news.lastModifiedDate ?? '')!)}",
                    style: secMed12.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : const SizedBox(),
            Text(news.name ?? '',
                style: secMed14.copyWith(fontWeight: FontWeight.w700)),
            Text(news.volume.toString()),
            const Divider()
          ],
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text("\$ ${news.price}",
              style: secMed12.copyWith(fontWeight: FontWeight.w700)),
          Text(news.change.toString(),
              style: secMed12.copyWith(
                  fontWeight: FontWeight.w600,
                  color: news.change! > 0 ? Colors.green : Colors.red))
        ])
      ]),
    );
  }
}
