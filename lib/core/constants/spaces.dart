import 'package:flutter/material.dart';

const double appPadding = 8.0; //  used for padding let from screen in whole app

const double appWidgetGap = 48.0; //  used for seprating two widget vertically

const double appViewAllPadding = 8.0; // used for view All button

const double appListViewHorizontalPadding =
    8.0; // used for list view horizontal padding

const double appTitleCategoryGap = 10.0;

/// this is used for gap between title(Feature cars etc..) and its list widget

const double appFormFieldGap = 12.0;

/// used for gap between two textfield

Widget appDivider() {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 16),
    child: Container(height: 8),
  );
}
