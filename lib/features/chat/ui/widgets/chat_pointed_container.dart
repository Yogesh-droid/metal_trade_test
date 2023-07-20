import 'package:flutter/material.dart';

class ChatPointedContainer extends StatelessWidget {
  const ChatPointedContainer(
      {super.key, required this.child, this.color, required this.isMyChat});
  final Widget child;
  final Color? color;
  final bool isMyChat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMyChat ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMyChat)
          ClipPath(
            clipper: TriangleClipperLeft(),
            child: Container(
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              height: 10,
              width: 20,
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                  color: color ?? Theme.of(context).colorScheme.onPrimary),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(14),
                bottomRight: const Radius.circular(14),
                topLeft: isMyChat ? const Radius.circular(14) : Radius.zero,
                topRight: isMyChat ? Radius.zero : const Radius.circular(14),
              )),
          child: child,
        ),
        if (isMyChat)
          ClipPath(
            clipper: TriangleClipperRight(),
            child: Container(
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              height: 10,
              width: 20,
            ),
          )
      ],
    );
  }
}

class TriangleClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(10, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipperRight oldClipper) => false;
}

class TriangleClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); // move to the bottom-left corner
    path.lineTo(size.width, 10); // draw a line to the middle-right
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipperLeft oldClipper) => false;
}
