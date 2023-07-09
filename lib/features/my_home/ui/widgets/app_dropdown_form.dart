import 'package:flutter/material.dart';

class AppDropdownFormField extends StatelessWidget {
  const AppDropdownFormField(
      {super.key,
      this.hintText,
      this.onChange,
      this.onValidate,
      this.prefix,
      this.suffix,
      required this.items});
  final String? hintText;
  final Function(Object? object)? onChange;
  final String? Function(String? value)? onValidate;
  final Widget? prefix;
  final List<DropdownMenuItem<String>> items;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
              gapPadding: 8),
        ),
        items: items,
        onChanged: onChange);
  }
}
