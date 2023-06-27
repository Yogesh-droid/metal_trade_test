import 'package:get_it/get_it.dart';
import 'package:metaltrade/features/auth/data/repo/login_repo_impl.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';
import 'package:metaltrade/features/auth/domain/repo/validate_otp_repo.dart';
import 'package:metaltrade/features/auth/domain/usecases/login_usecase.dart';
import 'package:metaltrade/features/auth/domain/usecases/validate_otp_usecase.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/auth/ui/controllers/validate_otp/validate_otp_bloc.dart';
import 'package:metaltrade/features/enquiry/data/repo/post_enquiry_repo_impl.dart';
import 'package:metaltrade/features/enquiry/data/repo/sku_repo_impl.dart';
import 'package:metaltrade/features/enquiry/domain/repo/post_enquiry_repo.dart';
import 'package:metaltrade/features/enquiry/domain/repo/sku_repo.dart';
import 'package:metaltrade/features/enquiry/domain/usecases/post_enquiry_usecase.dart';
import 'package:metaltrade/features/enquiry/domain/usecases/sku_usecase.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/get_sku/get_sku_bloc.dart';
import 'package:metaltrade/features/home/domain/repo/home_page_enquiry_repo.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/news/data/repo/news_repo_impl.dart';
import 'package:metaltrade/features/news/domain/repo/news_repo.dart';
import 'package:metaltrade/features/news/domain/usecases/news_usecase.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/profile/domain/repo/get_profile_repo.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/quotes/domain/usecases/accept_quote_res_usecase.dart';
import 'package:metaltrade/features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import '../../features/auth/data/repo/validate_otp_repo_impl.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
import '../../features/home/data/repo/home_page_enquiry_repo_impl.dart';
import '../../features/profile/data/repo/profile_repo_impl.dart';
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

  ///   Validate OTP  //
  getIt.registerFactory<ValidateOtpRepo>(
      () => ValidateOtpRepoImpl(networkManager: getIt()));
  getIt.registerFactory<ValidateOtpUsecase>(
      () => ValidateOtpUsecase(validateOtpRepo: getIt()));
  getIt.registerFactory<ValidateOtpBloc>(
      () => ValidateOtpBloc(validateOtpUsecase: getIt()));

  // THis is My Enquiry bloc setup //
  // homePage usecase and repo is used in this as they have same data //

  getIt.registerFactory<MyEnquiryBloc>(
      () => MyEnquiryBloc(homePageEnquiryUsecase: getIt()));

  getIt.registerFactory<MyEnquirySellBloc>(
      () => MyEnquirySellBloc(homePageEnquiryUsecase: getIt()));

  // setup for create enquiry bloc //

  getIt.registerFactory<PostEnquiryRepo>(
      () => PostEnquiryRepoImpl(networkManager: getIt()));
  getIt.registerFactory<PostEnquiryUsecase>(
      () => PostEnquiryUsecase(postEnquiryRepo: getIt()));
  getIt.registerFactory<CreateEnquiryBloc>(() => CreateEnquiryBloc(getIt()));

  // Sku Fetch on post enquiry for setup //
  getIt.registerFactory<SkuRepo>(() => SkuRepoImpl(networkManager: getIt()));
  getIt.registerFactory<SkuUsecase>(() => SkuUsecase(skuRepo: getIt()));
  getIt.registerFactory<GetSkuBloc>(() => GetSkuBloc(getIt()));

  // profile setup //

  getIt.registerFactory<GetProfileRepo>(() => ProfileRepoImpl(getIt()));
  getIt.registerFactory<GetProfileUsecase>(
      () => GetProfileUsecase(profileRepo: getIt()));
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(getIt()));

  // News Bloc  //
  getIt.registerFactory<NewsRepo>(() => NewsRepoImpl(networkManager: getIt()));
  getIt.registerFactory<NewUsecase>(() => NewUsecase(newsRepo: getIt()));
  getIt.registerFactory<NewsBloc>(() => NewsBloc(newUsecase: getIt()));

  // Accept quote setup ///

  getIt.registerFactory<AcceptQuoteResUsecase>(
      () => AcceptQuoteResUsecase(acceptQuoteResRepo: getIt()));
  getIt.registerFactory<AcceptQuoteBloc>(() => AcceptQuoteBloc(getIt()));
}
