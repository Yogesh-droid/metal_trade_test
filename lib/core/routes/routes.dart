import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/features/auth/ui/screens/login_page.dart';
import 'package:metaltrade/features/auth/ui/screens/pin_put_page.dart';
import 'package:metaltrade/features/landing/ui/screens/landing_page.dart';
import 'package:metaltrade/features/profile/ui/screens/kyc_screen.dart';
import 'package:metaltrade/features/profile/ui/screens/profile_screen.dart';
import '../../features/dashboard/ui/screens/dashboard.dart';
import '../../features/my_home/ui/screens/create_enquiry_screen.dart';
import '../../features/onboarding/screens/welcome_page.dart';
import '../../features/rfq/data/models/rfq_enquiry_model.dart';
import '../../features/rfq/ui/screens/product_detail_screen.dart';

const String welcomePageRoute = '/';
const String landingPageRoute = '/landingPage';
const String loginPageRoute = '/loginPage';
const String dashBoardRoute = '/dashBoard';
const String otpPageROute = "/otpPageRoute";
const String otpPageName = "otpPage";
const String createEnquiryRoute = '/createEnquiryRoute';
const String createEnquiryPageName = 'CreateEnquiryPageName';
const String profilePageRoute = '/profilePageRoute';
const String profilePageName = 'ProfilePageName';
const String kycPageName = 'KycPageName';
const String kycPageRoute = '/kycPageRoute';
const String productDetailPageRoute = "/productDetailPageRoute";
const String productDetailPageRouteName = "ProductDetailPageRouteName";

final GoRouter router = GoRouter(initialLocation: welcomePageRoute, routes: [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return const MaterialPage(child: WelcomePage());
    },
  ),
  GoRoute(
    path: landingPageRoute,
    pageBuilder: (context, state) {
      return getTransition(
          child: const LandingPage(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: dashBoardRoute,
    pageBuilder: (context, state) {
      return getTransition(
          child: const DashBoard(),
          animationType: TransitionType.fade,
          duration: const Duration(milliseconds: 500));
    },
  ),
  GoRoute(
    path: loginPageRoute,
    pageBuilder: (context, state) {
      return getTransition(
          child: const LoginPage(),
          animationType: TransitionType.fade,
          duration: const Duration(milliseconds: 500));
    },
  ),
  GoRoute(
    path: otpPageROute,
    name: otpPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: PinPutPage(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: createEnquiryRoute,
    name: createEnquiryPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: const CreateEnquiryScreen(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: profilePageRoute,
    name: profilePageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: const ProfileScreen(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: kycPageRoute,
    name: kycPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: const KycScreen(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: productDetailPageRoute,
    name: productDetailPageRouteName,
    pageBuilder: (context, state) {
      return getTransition(
          child: ProductDetailScreen(item: state.extra as Content),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
]);

Page<dynamic> getTransition(
    {required Widget child,
    Duration? duration,
    TransitionType? animationType}) {
  return CustomTransitionPage(
      child: child,
      transitionDuration: duration ?? const Duration(seconds: 1),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        switch (animationType) {
          /**
               * this is for sliding animation for a page to enter in stack
               * 
               * you can change offset to set enter position accordingly
               */
          case TransitionType.slide:
            return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeIn)),
                ),
                child: child);

          /**
                 * this is fade animation
                 */
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);

          /**
               * this is scale transtion
               */

          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);

          /**
                 * this is rotation transition
                 * 
                 */

          case TransitionType.rotation:
            return RotationTransition(
              turns: animation,
              child: child,
            );

          default:
            return child;
        }
      });
}

enum TransitionType { fade, scale, slide, rotation, none }
