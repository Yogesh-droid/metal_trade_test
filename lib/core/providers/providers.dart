import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/search_controller/search_bloc.dart';
import '../../features/auth/data/models/country_code_model.dart';
import '../../features/auth/ui/controllers/country_code_controller.dart';
import '../../features/auth/ui/controllers/login_bloc/login_bloc.dart';
import '../../features/auth/ui/controllers/validate_otp/validate_otp_bloc.dart';
import '../../features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../features/dashboard/ui/controllers/bottom_bar_controller_cubit.dart';
import '../../features/enquiry/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import '../../features/enquiry/ui/controllers/get_sku/get_sku_bloc.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import '../../features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
import '../../features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import '../../features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import '../../features/news/ui/controllers/news_bloc/news_bloc.dart';
import '../../features/profile/ui/controllers/country_cubit/country_cubit.dart';
import '../../features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import '../../features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import '../constants/app_theme.dart';
import '../di/get_it_setup.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => AppTheme(lightTheme)),
        BlocProvider(create: (context) => BottomNavControllerCubit()),
        BlocProvider(
            create: (context) => CountryCodeController(CountryCodeModel())),
        BlocProvider<HomePageBuyerEnquiryBloc>(create: (context) => getIt()),
        BlocProvider<SearchBloc>(create: (context) => getIt()),
        BlocProvider<HomePageSellerEnquiryBloc>(create: (context) => getIt()),
        BlocProvider<LoginBloc>(create: (context) => getIt()),
        BlocProvider<ValidateOtpBloc>(create: (context) => getIt()),
        BlocProvider<MyEnquiryBloc>(create: (context) => getIt()),
        BlocProvider<MyEnquirySellBloc>(create: (context) => getIt()),
        BlocProvider<CreateEnquiryBloc>(create: (context) => getIt()),
        BlocProvider<GetSkuBloc>(create: (context) => getIt()),
        BlocProvider<NewsBloc>(create: (context) => getIt()),
        BlocProvider<AcceptQuoteBloc>(create: (context) => getIt()),
        BlocProvider<ProfileBloc>(create: (context) => getIt()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
        BlocProvider<KycBloc>(create: (context) => getIt()),
        BlocProvider<CountryCubit>(create: (context) => getIt())
      ];
}
