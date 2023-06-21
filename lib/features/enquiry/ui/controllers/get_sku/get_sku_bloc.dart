import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/enquiry/data/models/sku_model.dart';
import 'package:metaltrade/features/enquiry/domain/entities/sku_entity.dart';
import '../../../domain/usecases/sku_usecase.dart';
part 'get_sku_event.dart';
part 'get_sku_state.dart';

class GetSkuBloc extends Bloc<GetSkuEvent, GetSkuState> {
  final SkuUsecase skuUsecase;
  final List<Content> skuList = [];
  GetSkuBloc(this.skuUsecase) : super(GetSkuInitial()) {
    on<GetSkuEvent>((event, emit) async {
      if (event is GetAllSkuEvent) {
        try {
          final DataState<SkuEntity> dataState = await skuUsecase.call(
              RequestParams(
                  url: "${baseUrl}sku?page=0&size=20",
                  apiMethods: ApiMethods.get));
          if (dataState.data != null) {
            for (var element in dataState.data!.content!) {
              skuList.add(element);
            }
            emit(AllSkuFetched(skuList: skuList));
          }
        } on Exception catch (e) {
          emit(AllSkuFailed(e));
        }
      }
    });
  }
}
