part of 'get_sku_bloc.dart';

@immutable
abstract class GetSkuState {}

class GetSkuInitial extends GetSkuState {}

class AllSkuFetched extends GetSkuState {
  final List<Content> skuList;

  AllSkuFetched({required this.skuList});
}

class AllSkuFailed extends GetSkuState {
  final Exception exception;

  AllSkuFailed(this.exception);
}
