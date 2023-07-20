import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';
import 'package:metaltrade/features/news/ui/controllers/news_filter_status_cubit/news_filter_status_cubit.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/submit_quote/submit_quote_bloc.dart';
import '../../features/auth/data/models/country_code_model.dart';
import '../../features/auth/ui/controllers/country_code_controller.dart';
import '../../features/auth/ui/controllers/login_bloc/login_bloc.dart';
import '../../features/auth/ui/controllers/validate_otp/validate_otp_bloc.dart';
import '../../features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../features/dashboard/ui/controllers/bottom_bar_controller_cubit.dart';
import '../../features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import '../../features/my_home/ui/controllers/get_sku/get_sku_bloc.dart';
import '../../features/my_home/ui/controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import '../../features/news/ui/controllers/news_bloc/news_bloc.dart';
import '../../features/profile/ui/controllers/country_cubit/country_cubit.dart';
import '../../features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import '../../features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import '../../features/rfq/ui/controllers/search_controller/search_bloc.dart';
import '../constants/app_theme.dart';
import '../di/get_it_setup.dart';

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
        BlocProvider<QuoteDetailListBloc>(create: (_) => getIt())
      ];
}
