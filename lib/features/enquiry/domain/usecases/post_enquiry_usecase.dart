import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/enquiry/domain/entities/post_enquiry_res_entity.dart';
import 'package:metaltrade/features/enquiry/domain/repo/post_enquiry_repo.dart';

class PostEnquiryUsecase extends Usecase {
  final PostEnquiryRepo postEnquiryRepo;

  PostEnquiryUsecase({required this.postEnquiryRepo});
  @override
  Future<DataState<PostEnquiryResEntity>> call(params) async {
    return await postEnquiryRepo.postEnquiry(params);
  }
}
