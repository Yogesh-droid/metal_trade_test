import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';

class GetStartedBtn extends StatelessWidget {
  const GetStartedBtn(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height,
      this.width});
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 60,
      child: ElevatedButton(onPressed: onPressed, child: Text(title)),
    );
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height,
      this.width});
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(title));
  }
}

class OutlinedIconButtonWidget extends StatelessWidget {
  const OutlinedIconButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height,
      this.width,
      required this.icon});
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton.icon(
          onPressed: onPressed, icon: icon, label: Text(title)),
    );
  }
}

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height,
      this.color,
      this.width,
      this.textColor});

  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle()
                  .copyWith(
                      foreground: Paint()..color = textColor ?? Colors.white)),
            ),
            onPressed: onPressed,
            child: Text(title)));
  }
}

class FilledButtonLoading extends StatelessWidget {
  const FilledButtonLoading({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: FilledButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey[400])),
            onPressed: null,
            child: const LoadingDots()));
  }
}

class FilledButtonIconWidget extends StatelessWidget {
  const FilledButtonIconWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height,
      this.width,
      required this.icon});

  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton.icon(
          onPressed: onPressed, icon: icon, label: Text(title)),
    );
  }
}
