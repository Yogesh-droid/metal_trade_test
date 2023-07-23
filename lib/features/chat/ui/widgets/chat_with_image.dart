import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';

class ChatWithImage extends StatelessWidget {
  const ChatWithImage({super.key, this.image, this.caption});
  final String? image;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(children: [
        CachedNetworkImage(imageUrl: image ?? ''),
        Text(caption ?? '')
      ]),
    );
  }
}
