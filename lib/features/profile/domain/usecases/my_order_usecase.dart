import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/entities/my_order_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/my_order_repo.dart';

class MyOrderUsecase extends Usecase {
  final MyOrderRepo myOrderRepo;

  MyOrderUsecase({required this.myOrderRepo});
  @override
  Future<DataState<MyOrderEntity>> call(params) async {
    return await myOrderRepo.getMyOrder(params);
  }
}
