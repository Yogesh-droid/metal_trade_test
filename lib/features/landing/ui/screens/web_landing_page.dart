import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/routes/routes.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to My Landing Page',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 40),
                FilledButton(
                  onPressed: () async {
                    await LocalStorage.instance.getToken().then((value) {
                      if (value.isEmpty) {
                        context.go(landingPageRoute);
                      } else {
                        debugPrint("token is =>=>=>=>  $value");
                        context.go(dashBoardRoute);
                      }
                    });
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
