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
      child: SizedBox(
        height: 48,
        child: TextFormField(
          enabled: false,
          controller: textEditingController,
          validator: onValidate,
          decoration: InputDecoration(
              suffixIcon: suffix,
              contentPadding: const EdgeInsets.only(top: 5, left: 8),
              fillColor: Theme.of(context).colorScheme.onPrimary,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant)),
              suffix: suffix,
              hintText: hintText),
        ),
      ),
    );
  }
}
