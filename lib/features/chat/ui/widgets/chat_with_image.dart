import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatWithImage extends StatelessWidget {
  const ChatWithImage({super.key, this.image, this.caption});
  final String? image;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CachedNetworkImage(imageUrl: image ?? ''),
      Text(caption ?? '')
    ]);
  }
}
