import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/entities/my_order_entity.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class MyOrderRepo {
  Future<DataState<MyOrderEntity>> getMyOrder(RequestParams requestParams);
}
