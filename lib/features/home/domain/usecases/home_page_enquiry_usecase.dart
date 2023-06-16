import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/home/domain/entities/home_page_enquiry_entity.dart';
import 'package:metaltrade/features/home/domain/repo/home_page_enquiry_repo.dart';

class HomePageEnquiryUsecase extends Usecase {
  final HomePageEnquiryRepo homePageEnquiryRepo;

  HomePageEnquiryUsecase({required this.homePageEnquiryRepo});
  @override
  Future<DataState<HomePageEnquiryEntity>> call(params) async {
    return await homePageEnquiryRepo.getHomePageEnquiries(params);
  }
}
