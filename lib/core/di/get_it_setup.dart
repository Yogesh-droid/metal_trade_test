part of 'get_it_imports.dart';

GetIt getIt = GetIt.I;
void setup() {
  /// Network calls
  getIt.registerLazySingleton(() => NetworkManager());
  getIt.registerLazySingleton(() => ImagePickerManager());

  // chat file upload setup

  getIt.registerFactory<ChatFilePickRepo>(() => ChatFilePickRepoImpl(getIt()));
  getIt
      .registerFactory<ChatFilePickUsecsse>(() => ChatFilePickUsecsse(getIt()));
  getIt.registerFactory<ChatFilePickCubit>(() => ChatFilePickCubit(getIt()));

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

  getIt.registerFactory<ChatFileUploadRepo>(
      () => ChatFileUploadRepoImpl(getIt()));
  getIt.registerFactory<ChatFileUploadUsecase>(
      () => ChatFileUploadUsecase(getIt()));

  getIt.registerFactory<PostEnquiryRepo>(
      () => PostEnquiryRepoImpl(networkManager: getIt()));
  getIt.registerFactory<PostEnquiryUsecase>(
      () => PostEnquiryUsecase(postEnquiryRepo: getIt()));
  getIt.registerFactory<CreateEnquiryBloc>(() => CreateEnquiryBloc(
      chatFileUploadUsecase: getIt(), postEnquiryUsecase: getIt()));

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

  getIt.registerFactory<EnquiryFilePickCubit>(
      () => EnquiryFilePickCubit(getIt()));

  getIt.registerFactory<ChatListRepo>(
      () => ChatListRepoImpl(networkManager: getIt()));
  getIt.registerFactory<ChatListUsecase>(
      () => ChatListUsecase(chatListRepo: getIt()));
  getIt.registerFactory<ChatBloc>(
      () => ChatBloc(chatListUsecase: getIt(), chatFileUploadUsecase: getIt()));

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

  // set up for Request call back in web page //

  getIt.registerFactory<RequestCallbackRepo>(
      () => RequestCallbackRepoImpl(getIt()));
  getIt.registerFactory<RequestCallbackUsecase>(
      () => RequestCallbackUsecase(requestCallbackRepo: getIt()));
  getIt.registerFactory<RequestCallbackCubit>(
      () => RequestCallbackCubit(getIt()));

  // set up for my order list //

  getIt.registerFactory<MyOrderRepo>(
      () => MyOrderRepoImpl(networkManager: getIt()));
  getIt.registerFactory<MyOrderUsecase>(
      () => MyOrderUsecase(myOrderRepo: getIt()));
  getIt.registerFactory<MyOrderBloc>(() => MyOrderBloc(getIt()));
}
