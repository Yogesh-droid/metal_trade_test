import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';

import '../../../../core/constants/app_colors.dart';

class BorderedTextField extends StatelessWidget {
  const BorderedTextField(
      {super.key,
      this.hintText,
      this.onChange,
      this.focusNode,
      this.textEditingController,
      this.onDone,
      this.textInputType,
      this.maxLines,
      required this.isObscureText,
      this.onValidate,
      this.prefix,
      this.suffix,
      this.textInputAction});
  final String? hintText;
  final Function(String s)? onChange;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final Function(String s)? onDone;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool isObscureText;
  final String? Function(String? value)? onValidate;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      focusNode: focusNode,
      keyboardType: textInputType,
      decoration: InputDecoration(
        //border: const UnderlineInputBorder(),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: blue),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: blue),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: grey4),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: blue),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        labelText: hintText,
        labelStyle: const TextStyle(color: blue),
        prefix: prefix,
        suffix: suffix,
      ),
      cursorColor: black,
      style: const TextStyle(color: grey2),
      textInputAction: textInputAction,
      onFieldSubmitted: onDone,
      maxLength: maxLines,
      obscureText: isObscureText,
      controller: textEditingController,
      validator: onValidate,
      enableIMEPersonalizedLearning: true,
    );
  }
}
