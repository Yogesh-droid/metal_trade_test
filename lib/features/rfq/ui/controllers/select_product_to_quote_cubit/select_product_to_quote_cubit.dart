import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

part 'select_product_to_quote_state.dart';

class SelectProductToQuoteCubit extends Cubit<SelectProductToQuoteState> {
  SelectProductToQuoteCubit() : super(SelectProductToQuoteInitial());
  // List<int> selectedIndex = [];
  List<Item> selectedItems = [];
  double price = 0;
  int quantity = 0;

  void changePrice(Item item, double price1) {
    price = price1;
    selectedItems.elementAt(selectedItems.indexOf(item)).price = price1;
    emit(SelectProductPriceChanged(price));
  }

  void changeQuantity(Item item, int quantity1) {
    quantity = quantity1;
    selectedItems.elementAt(selectedItems.indexOf(item)).quantity = quantity1;
    emit(SelectProductQuantityChanged(quantity));
  }

  void selectItem(int id, Item item) {
    // selectedIndex.contains(id)
    //     ? selectedIndex.remove(id)
    //     : selectedIndex.add(id);
    selectedItems.contains(item)
        ? selectedItems.remove(item)
        : selectedItems.add(item);
    emit(SelectedProductToQuoteChanged(selectedIndex: const []));
  }
}
