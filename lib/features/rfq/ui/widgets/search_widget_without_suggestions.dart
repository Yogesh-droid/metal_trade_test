import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

class SearchWidgetWithoutSuggestions extends StatelessWidget {
  const SearchWidgetWithoutSuggestions(
      {super.key,
      required this.textEditingController,
      required this.onSearchTapped,
      required this.focusNode});
  final TextEditingController textEditingController;
  final Function(String text) onSearchTapped;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          hintStyle: secMed12,
          fillColor: Theme.of(context).colorScheme.onPrimary,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(50),
              gapPadding: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(50),
              gapPadding: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(50),
              gapPadding: 8),
          hintText: kSearchEnquiry.tr(),
          suffixIcon: IconButton(
              onPressed: () {
                onSearchTapped(textEditingController.text);
              },
              icon: const Icon(Icons.search))),
      cursorColor: Theme.of(context).colorScheme.scrim,
      style: TextStyle(color: Theme.of(context).colorScheme.scrim),
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onSearchTapped,
      controller: textEditingController,
      enableIMEPersonalizedLearning: true,
    );
  }
}
