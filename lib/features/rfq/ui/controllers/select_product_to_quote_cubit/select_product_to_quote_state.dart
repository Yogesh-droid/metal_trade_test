part of 'select_product_to_quote_cubit.dart';

@immutable
abstract class SelectProductToQuoteState {}

class SelectProductToQuoteInitial extends SelectProductToQuoteState {}

class SelectedProductToQuoteChanged extends SelectProductToQuoteState {
  final List<int> selectedIndex;

  SelectedProductToQuoteChanged({required this.selectedIndex});
}

class SelectProductPriceChanged extends SelectProductToQuoteState {
  final double price;

  SelectProductPriceChanged(this.price);
}

class SelectProductQuantityChanged extends SelectProductToQuoteState {
  final int quantity;

  SelectProductQuantityChanged(this.quantity);
}
