part of 'provider_import.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (_) => AppTheme(lightTheme)),
        BlocProvider(create: (_) => BottomNavControllerCubit()),
        BlocProvider(create: (_) => CountryCodeController(CountryCodeModel())),
        BlocProvider<RfqBuyerEnquiryBloc>(create: (_) => getIt()),
        BlocProvider<SearchBloc>(create: (_) => getIt()),
        BlocProvider<RfqSellerEnquiryBloc>(create: (_) => getIt()),
        BlocProvider<LoginBloc>(create: (_) => getIt()),
        BlocProvider<ValidateOtpBloc>(create: (_) => getIt()),
        BlocProvider<MyRfqBloc>(create: (_) => getIt()),
        BlocProvider<MyQuoteBloc>(create: (_) => getIt()),
        BlocProvider<CreateEnquiryBloc>(create: (_) => getIt()),
        BlocProvider<GetSkuBloc>(create: (_) => getIt()),
        BlocProvider<NewsBloc>(create: (_) => getIt()),
        BlocProvider<AcceptQuoteBloc>(create: (_) => getIt()),
        BlocProvider<ProfileBloc>(create: (_) => getIt()),
        BlocProvider<ChatBloc>(create: (_) => getIt()),
        BlocProvider<KycBloc>(create: (_) => getIt()),
        BlocProvider<CountryCubit>(create: (_) => getIt()),
        BlocProvider<FilterStatusCubit>(create: (_) => FilterStatusCubit()),
        BlocProvider<NewsFilterStatusCubit>(
            create: (_) => NewsFilterStatusCubit()),
        BlocProvider<SubmitQuoteBloc>(create: (_) => getIt()),
        BlocProvider(create: (_) => QuoteFilterCubit()),
        BlocProvider<ChatHomeBloc>(create: (_) => getIt()),
        BlocProvider<QuoteDetailListBloc>(create: (_) => getIt()),
        BlocProvider(create: (_) => SelectProductToQuoteCubit()),
        BlocProvider<RequestCallbackCubit>(create: (_) => getIt()),
        BlocProvider<MyOrderBloc>(create: (_) => getIt())
      ];
}
