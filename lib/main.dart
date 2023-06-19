import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:metaltrade/features/auth/data/models/country_code_model.dart';
import 'package:metaltrade/features/auth/ui/controllers/country_code_controller.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'core/constants/app_theme.dart';
import 'core/di/get_it_setup.dart';
import 'core/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'features/dashboard/ui/controllers/bottom_bar_controller_cubit.dart';
import 'features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import 'features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
import 'features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';

Future<void> main(List<String> args) async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (!kIsWeb) {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
  }
  runApp(const MetalTradeApp());
}

class MetalTradeApp extends StatelessWidget {
  const MetalTradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavControllerCubit()),
          BlocProvider(
              create: (context) => CountryCodeController(CountryCodeModel())),
          BlocProvider<HomePageBuyerEnquiryBloc>(create: (context) => getIt()),
          BlocProvider<HomePageSellerEnquiryBloc>(create: (context) => getIt()),
          BlocProvider<LoginBloc>(create: (context) => getIt()),
          BlocProvider<MyEnquiryBloc>(create: (context) => getIt()),
          BlocProvider<MyEnquirySellBloc>(create: (context) => getIt()),
          BlocProvider<CreateEnquiryBloc>(create: (context) => getIt())
        ],
        child: MaterialApp.router(
          title: 'Metal Trade',
          theme: AppTheme.getAppTheme(context),
          routerConfig: router,
        ));
  }
}
