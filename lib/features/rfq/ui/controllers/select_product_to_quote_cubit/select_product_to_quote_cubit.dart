import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

part 'select_product_to_quote_state.dart';

class SelectProductToQuoteCubit extends Cubit<SelectProductToQuoteState> {
  SelectProductToQuoteCubit() : super(SelectProductToQuoteInitial());
  List<int> selectedIndex = [];
  List<Item> selectedItems = [];
  double price = 0;
  int quantity = 0;

  void changePrice(double price1) {
    print(price1);
    price = price1;
    emit(SelectProductPriceChanged(price));
  }

  void changeQuantity(int quantity1) {
    quantity = quantity1;
    emit(SelectProductQuantityChanged(quantity));
  }

  void selectItem(int id, Item item) {
    selectedIndex.contains(id)
        ? selectedIndex.remove(id)
        : selectedIndex.add(id);
    emit(SelectedProductToQuoteChanged(selectedIndex: selectedIndex));
  }
}
