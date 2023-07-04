import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';

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
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiaryContainer),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(appPadding),
            gapPadding: 8),
        labelText: hintText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        prefix: prefix,
        suffix: suffix,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
