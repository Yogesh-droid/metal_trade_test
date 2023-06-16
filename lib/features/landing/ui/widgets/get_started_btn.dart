import 'package:flutter/material.dart';

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
      child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: Text(title)),
    );
  }
}
