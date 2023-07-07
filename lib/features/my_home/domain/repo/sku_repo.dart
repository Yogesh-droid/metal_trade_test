import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../entities/sku_entity.dart';

abstract class SkuRepo {
  Future<DataState<SkuEntity>> getSku(RequestParams requestParams);
}
