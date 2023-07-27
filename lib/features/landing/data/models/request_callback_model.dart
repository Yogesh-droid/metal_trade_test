import 'package:metaltrade/features/landing/domain/entities/request_callback_entity.dart';

class RequestCallbackModel extends RequestCallbackEntity {
  RequestCallbackModel(
      {int? id,
      String? name,
      String? mobileNumber,
      String? message,
      String? status})
      : super(
            id: id,
            message: message,
            mobileNumber: mobileNumber,
            name: name,
            status: status);

  factory RequestCallbackModel.fromJson(Map<String, dynamic> json) {
    return RequestCallbackModel(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        message: json["message"],
        status: json["status"]);
  }
}
