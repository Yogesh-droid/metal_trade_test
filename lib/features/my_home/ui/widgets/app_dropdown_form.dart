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
    return SizedBox(
      height: 48,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.onPrimary,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).disabledColor),
            contentPadding: const EdgeInsets.only(left: 8, top: 5),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant),
                gapPadding: 8),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant),
                gapPadding: 8),
          ),
          items: items,
          onChanged: onChange),
    );
  }
}
