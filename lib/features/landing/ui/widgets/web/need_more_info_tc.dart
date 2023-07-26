import 'package:flutter/material.dart';

class NeedMoreInfoTc extends StatelessWidget {
  const NeedMoreInfoTc(
      {super.key,
      required this.onValidate,
      required this.onChange,
      required this.hint,
      required this.textEditingController});
  final String? Function(String?) onValidate;
  final Function(String) onChange;
  final String hint;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: onValidate,
      onChanged: onChange,
      decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant))),
    );
  }
}
