import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/landing/domain/entities/request_callback_entity.dart';
import 'package:metaltrade/features/landing/domain/repo/request_callback_repo.dart';

class RequestCallbackUsecase extends Usecase {
  final RequestCallbackRepo requestCallbackRepo;

  RequestCallbackUsecase({required this.requestCallbackRepo});
  @override
  Future<DataState<RequestCallbackEntity>> call(params) {
    return requestCallbackRepo.getCallBack(params);
  }
}
