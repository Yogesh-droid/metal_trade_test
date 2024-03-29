import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'core/constants/app_theme.dart';
import 'core/di/get_it_imports.dart';
import 'core/providers/provider_import.dart';
import 'core/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  setup();
  await dotenv.load(fileName: "dotenv");
  if (!kIsWeb) {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
  }
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
        Locale('zh', 'CN')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const RestartWidget(child: MetalTradeApp())));
}

class MetalTradeApp extends StatelessWidget {
  const MetalTradeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBlocProviders.allBlocProviders,
        child: BlocBuilder<AppTheme, ThemeData>(
          builder: (context, state) {
            return FlutterWebFrame(
              builder: (context) => MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Metal Trade',
                theme: state,
                routerConfig: router,
              ),
              maximumSize: Size(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height),
              enabled: kIsWeb,
              backgroundColor: Colors.white,
            );
          },
        ));
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({super.key, required this.child});

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
