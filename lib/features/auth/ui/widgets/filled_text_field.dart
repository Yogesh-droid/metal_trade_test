import 'package:flutter/material.dart';

class FilledTextFieldWidget extends StatelessWidget {
  const FilledTextFieldWidget(
      {super.key,
      required this.textEditingController,
      this.prefix,
      this.suffix,
      this.focusNode,
      this.onChange,
      this.onDone,
      this.textInputType,
      this.onValidate});
  final TextEditingController textEditingController;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final Function(String? value)? onChange;
  final Function(String? value)? onDone;
  final TextInputType? textInputType;
  final String? Function(String? value)? onValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSecondary,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enableIMEPersonalizedLearning: true,
        enableSuggestions: true,
        keyboardType: textInputType,
        autofocus: true,
        controller: textEditingController,
        validator: onValidate,
        decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.onPrimary,
            filled: true,
            prefix: prefix,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusColor: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
