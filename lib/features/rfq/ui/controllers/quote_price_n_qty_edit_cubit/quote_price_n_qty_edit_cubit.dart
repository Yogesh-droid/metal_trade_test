import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'quote_price_n_qty_edit_state.dart';

class QuotePriceNQtyEditCubit extends Cubit<QuotePriceNQtyEditState> {
  QuotePriceNQtyEditCubit() : super(QuotePriceNQtyEditInitial());

  void changePrice(int price) {}
}
