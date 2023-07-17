import 'package:flutter/material.dart';

class DisabledTextField extends StatelessWidget {
  const DisabledTextField(
      {super.key,
      this.hintText,
      this.textEditingController,
      this.onDone,
      this.onValidate,
      this.prefix,
      this.suffix,
      this.textInputAction,
      required this.onTap});
  final String? hintText;
  final TextEditingController? textEditingController;
  final Function(String s)? onDone;
  final String? Function(String? value)? onValidate;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        enabled: false,
        controller: textEditingController,
        validator: onValidate,
        decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.onPrimary,
            filled: true,
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                gapPadding: 8),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                gapPadding: 8),
            suffix: suffix,
            hintText: hintText),
      ),
    );
  }
}
