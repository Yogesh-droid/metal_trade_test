import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';

import '../entities/sku_entity.dart';
import '../repo/sku_repo.dart';

class SkuUsecase extends Usecase {
  final SkuRepo skuRepo;

  SkuUsecase({required this.skuRepo});
  @override
  Future<DataState<SkuEntity>> call(params) async {
    return await skuRepo.getSku(params);
  }
}
