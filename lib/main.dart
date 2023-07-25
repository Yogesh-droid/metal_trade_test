import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants/app_theme.dart';
import 'core/di/get_it_setup.dart';
import 'core/providers/providers.dart';
import 'core/routes/routes.dart';

Future<void> main(List<String> args) async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "dotenv");
  if (!kIsWeb) {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
  }
  // StompClientProvider.instance.stompCl.activate();
  runApp(const MetalTradeApp());
}

class MetalTradeApp extends StatelessWidget {
  const MetalTradeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBlocProviders.allBlocProviders,
        child: BlocBuilder<AppTheme, ThemeData>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Metal Trade',
              theme: state,
              routerConfig: router,
            );
          },
        ));
  }
}
