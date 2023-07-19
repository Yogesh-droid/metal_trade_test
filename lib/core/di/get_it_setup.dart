import 'package:get_it/get_it.dart';
import 'package:metaltrade/features/auth/data/repo/login_repo_impl.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';
import 'package:metaltrade/features/auth/domain/repo/validate_otp_repo.dart';
import 'package:metaltrade/features/auth/domain/usecases/login_usecase.dart';
import 'package:metaltrade/features/auth/domain/usecases/validate_otp_usecase.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/auth/ui/controllers/validate_otp/validate_otp_bloc.dart';
import 'package:metaltrade/features/chat/data/repo/chat_home_list_repo_impl.dart';
import 'package:metaltrade/features/chat/data/repo/chat_list_repo_impl.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_home_list_repo.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_list_repo.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_home_list_usecase.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_list_usecase.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/news/data/repo/news_repo_impl.dart';
import 'package:metaltrade/features/news/domain/repo/news_repo.dart';
import 'package:metaltrade/features/news/domain/usecases/news_usecase.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/profile/data/repo/country_repo_impl.dart';
import 'package:metaltrade/features/profile/data/repo/kyc_repo_impl.dart';
import 'package:metaltrade/features/profile/domain/repo/country_repo.dart';
import 'package:metaltrade/features/profile/domain/repo/get_profile_repo.dart';
import 'package:metaltrade/features/profile/domain/usecases/country_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/kyc_usecase.dart';
import 'package:metaltrade/features/profile/ui/controllers/country_cubit/country_cubit.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/quotes/domain/usecases/accept_quote_res_usecase.dart';
import 'package:metaltrade/features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import 'package:metaltrade/features/rfq/data/repo/quote_detail_list_repo_impl.dart';
import 'package:metaltrade/features/rfq/data/repo/rfq_enquiry_repo_impl.dart';
import 'package:metaltrade/features/rfq/data/repo/submit_quote_repo_impl.dart';
import 'package:metaltrade/features/rfq/domain/repo/quote_detail_list_repo.dart';
import 'package:metaltrade/features/rfq/domain/repo/rfq_enquiry_repo.dart';
import 'package:metaltrade/features/rfq/domain/repo/submit_quote_repo.dart';
import 'package:metaltrade/features/rfq/domain/usecases/quote_detail_list_usecase.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';
import 'package:metaltrade/features/rfq/domain/usecases/submit_quote_usecase.dart';
import 'package:metaltrade/features/rfq/ui/controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/submit_quote/submit_quote_bloc.dart';
import '../../features/auth/data/repo/validate_otp_repo_impl.dart';
import '../../features/my_home/data/repo/post_enquiry_repo_impl.dart';
import '../../features/my_home/data/repo/sku_repo_impl.dart';
import '../../features/my_home/domain/repo/post_enquiry_repo.dart';
import '../../features/my_home/domain/repo/sku_repo.dart';
import '../../features/my_home/domain/usecases/post_enquiry_usecase.dart';
import '../../features/my_home/domain/usecases/sku_usecase.dart';
import '../../features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import '../../features/my_home/ui/controllers/get_sku/get_sku_bloc.dart';
import '../../features/profile/data/repo/profile_repo_impl.dart';
import '../../features/profile/domain/repo/kyc_repo.dart';
import '../../features/rfq/ui/controllers/search_controller/search_bloc.dart';
import '../resource/network/network_manager.dart';

GetIt getIt = GetIt.I;
void setup() {
  /// Network calls
  getIt.registerLazySingleton(() => NetworkManager());

  /// For Rfq Page Banners
  getIt.registerFactory<RfqEnquiryRepo>(
      () => RfqEnquiryImpl(networkManager: getIt()));
  getIt.registerFactory<RfqUsecase>(() => RfqUsecase(rfqRepo: getIt()));
  getIt.registerFactory<RfqBuyerEnquiryBloc>(
      () => RfqBuyerEnquiryBloc(homePageEnquiryUsecase: getIt()));

  ///  Search Controller uses HomePageEnquiryRepo
  ///
  getIt.registerFactory<SearchBloc>(
      () => SearchBloc(homePageEnquiryUsecase: getIt()));

  ///  seller section bloc Home Page ///

  getIt.registerFactory<RfqSellerEnquiryBloc>(
      () => RfqSellerEnquiryBloc(homePageEnquiryUsecase: getIt()));

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

  getIt.registerFactory<MyRfqBloc>(
      () => MyRfqBloc(homePageEnquiryUsecase: getIt()));

  getIt.registerFactory<MyQuoteBloc>(
      () => MyQuoteBloc(homePageEnquiryUsecase: getIt()));

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

  //  Kyc page setup /   it uses profile entity and profile model

  getIt.registerFactory<KycRepo>(() => KycRepoImpl(networkManager: getIt()));
  getIt.registerFactory<KycUsecase>(() => KycUsecase(kycRepo: getIt()));
  getIt.registerFactory<KycBloc>(() => KycBloc(getIt()));

  //  Country setup  for kyc  //

  getIt.registerFactory<CountryRepo>(
      () => CountryRepoImpl(networkManager: getIt()));
  getIt.registerFactory<CountryUsecase>(
      () => CountryUsecase(countryRepo: getIt()));
  getIt.registerFactory<CountryCubit>(() => CountryCubit(getIt()));

  // News Bloc  //
  getIt.registerFactory<NewsRepo>(() => NewsRepoImpl(networkManager: getIt()));
  getIt.registerFactory<NewUsecase>(() => NewUsecase(newsRepo: getIt()));
  getIt.registerFactory<NewsBloc>(() => NewsBloc(newUsecase: getIt()));

  // Accept quote setup ///

  getIt.registerFactory<AcceptQuoteResUsecase>(
      () => AcceptQuoteResUsecase(acceptQuoteResRepo: getIt()));
  getIt.registerFactory<AcceptQuoteBloc>(() => AcceptQuoteBloc(getIt()));

  // SubmitQuote bLoc setup //
  getIt.registerFactory<SubmitQuoteRepo>(
      () => SubmitQuoteRepoImpl(networkManager: getIt()));
  getIt.registerFactory<SubmitQuoteUsecase>(
      () => SubmitQuoteUsecase(submitQuoteRepo: getIt()));
  getIt.registerFactory<SubmitQuoteBloc>(
      () => SubmitQuoteBloc(submitQuoteUsecase: getIt()));

  // CHat list Bloc setup //

  getIt.registerFactory<ChatListRepo>(
      () => ChatListRepoImpl(networkManager: getIt()));
  getIt.registerFactory<ChatListUsecase>(
      () => ChatListUsecase(chatListRepo: getIt()));
  getIt.registerFactory<ChatBloc>(() => ChatBloc(chatListUsecase: getIt()));

  getIt.registerFactory<ChatHomeListRepo>(
      () => ChatHomeListRepoImpl(networkManager: getIt()));
  getIt.registerFactory<ChatHomeListUsecase>(
      () => ChatHomeListUsecase(chatHomeListRepo: getIt()));
  getIt.registerFactory<ChatHomeBloc>(() => ChatHomeBloc(getIt()));

  // set up for quote list on enquiry detail //

  getIt.registerFactory<QuoteDetailListRepo>(
      () => QuoteDetailListRepoImpl(networkManager: getIt()));
  getIt.registerFactory<QuoteDetailListUsecase>(
      () => QuoteDetailListUsecase(quoteDetailListRepo: getIt()));
  getIt
      .registerFactory<QuoteDetailListBloc>(() => QuoteDetailListBloc(getIt()));
}
