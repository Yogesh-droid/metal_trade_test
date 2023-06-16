import 'package:get_it/get_it.dart';
import 'package:metaltrade/features/home/domain/repo/home_page_enquiry_repo.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import '../../features/home/data/repo/home_page_enquiry_repo_impl.dart';
import '../resource/network/network_manager.dart';

GetIt getIt = GetIt.I;
void setup() {
  /// Network calls
  getIt.registerLazySingleton(() => NetworkManager());

  /// For Home Page Banners
  getIt.registerFactory<HomePageEnquiryRepo>(
      () => HomePageEnquiryImpl(networkManager: getIt()));
  getIt.registerFactory<HomePageEnquiryUsecase>(
      () => HomePageEnquiryUsecase(homePageEnquiryRepo: getIt()));
  getIt.registerFactory<HomePageBuyerEnquiryBloc>(
      () => HomePageBuyerEnquiryBloc(homePageEnquiryUsecase: getIt()));

  ///  seller section bloc Home Page ///

  getIt.registerFactory<HomePageSellerEnquiryBloc>(
      () => HomePageSellerEnquiryBloc(homePageEnquiryUsecase: getIt()));
}
