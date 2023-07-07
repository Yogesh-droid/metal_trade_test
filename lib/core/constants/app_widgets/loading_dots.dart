import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late Animation animation1;
  late Animation animation2;
  late AnimationController animationController;
  @override
  void initState() {
    Tween<double> tween = Tween(begin: 0.0, end: 2.0);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
    animation = tween.animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut)));
    animation1 = tween.animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.9, curve: Curves.easeOut)));
    animation2 = tween.animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));
    animationController.forward();
    animationController.addStatusListener((value) {
      if (value == AnimationStatus.completed) {
        animationController.reverse();
      }
      if (value == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        animationBuilder(animation),
        const SizedBox(width: 10),
        animationBuilder(animation1),
        const SizedBox(width: 10),
        animationBuilder(animation2)
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  AnimatedBuilder animationBuilder(Animation animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(scale: animation.value, child: child);
      },
      child: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
