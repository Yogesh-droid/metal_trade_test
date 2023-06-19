import 'package:get_it/get_it.dart';
import 'package:metaltrade/features/auth/data/repo/login_repo_impl.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';
import 'package:metaltrade/features/auth/domain/usecases/login_usecase.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/home/domain/repo/home_page_enquiry_repo.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
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

  /// Login page setup ////
  getIt
      .registerFactory<LoginRepo>(() => LoginRepoImpl(networkManager: getIt()));
  getIt.registerFactory<LoginUsecase>(() => LoginUsecase(loginRepo: getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(loginUsecase: getIt()));

  // THis is My Enquiry bloc setup //
  // homePage usecase and repo is used in this as they have same data //

  getIt.registerFactory<MyEnquiryBloc>(
      () => MyEnquiryBloc(homePageEnquiryUsecase: getIt()));

  getIt.registerFactory<MyEnquirySellBloc>(
      () => MyEnquirySellBloc(homePageEnquiryUsecase: getIt()));
}
