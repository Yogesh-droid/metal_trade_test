import 'package:flutter/widgets.dart';

class AnimatedEmoji extends StatefulWidget {
  const AnimatedEmoji({super.key});

  @override
  State<AnimatedEmoji> createState() => _AnimatedEmojiState();
}

class _AnimatedEmojiState extends State<AnimatedEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: animationController.value * 2.0 * 3.1415,
            child: const Text(
              '\u{1F600}',
              style: TextStyle(fontSize: 50),
            ),
          );
        });
  }
}
