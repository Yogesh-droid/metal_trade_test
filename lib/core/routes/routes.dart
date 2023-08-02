import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/features/auth/ui/screens/login_page.dart';
import 'package:metaltrade/features/auth/ui/screens/pin_put_page.dart';
import 'package:metaltrade/features/chat/ui/screens/chat_test_page.dart';
import 'package:metaltrade/features/landing/ui/screens/landing_page.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/ui/screens/kyc_screen.dart';
import 'package:metaltrade/features/profile/ui/screens/my_order_screen.dart';
import 'package:metaltrade/features/profile/ui/screens/profile_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_enquiry_detail.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_page.dart';
import 'package:metaltrade/features/rfq/ui/screens/rfq_detail_page.dart';
import 'package:metaltrade/features/rfq/ui/screens/submit_quote_screen.dart';
import '../../features/dashboard/ui/screens/dashboard.dart';
import '../../features/my_home/ui/screens/create_enquiry_screen.dart';
import '../../features/onboarding/screens/welcome_page.dart';
import '../../features/rfq/data/models/rfq_enquiry_model.dart';
import '../../features/chat/data/models/chat_response_model.dart' as chat_res;

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
const String enquiryDetailPageRoute = "/enquiryDetailPageRoute";
const String enquiryDetailPageName = "EnquiryDEtailPageName"; //
const String submitQuotePageName = "SubmitQuotePageName";
const String submitQuotePageRoute = "/submitQuotePage";
const String chatPageRoute = "/chatPage";
const String chatPageName = "ChatPageName";
const String myQuotePageScreenName = "MyQuotePageRouteName";
const String myQuotePageRoute = "/myQuotePageRoute";
const String myEnqiryDetailPageName = "MyEnquiryDetailsPage"; //
const String myEnquiryPageRoute = "/myEnuiryPageRoute";
const String myOrderScreenRoute = "/myOrderPage";
const String myOrderScreenName = "MyOrderScreenName";

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
          child: const PinPutPage(),
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
          child: KycScreen(profileEntity: state.extra as ProfileEntity),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: enquiryDetailPageRoute,
    name: enquiryDetailPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: RfqDetailPage(
              content: state.extra as Content,
              title: state.uri.queryParameters['title']!),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: myEnquiryPageRoute,
    name: myEnqiryDetailPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: MyEnquiryDetail(item: state.extra as Content),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: submitQuotePageRoute,
    name: submitQuotePageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: SubmitQuoteScreen(content: state.extra as Content),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: chatPageRoute,
    name: chatPageName,
    pageBuilder: (context, state) {
      return getTransition(
          child: ChatTestPage(
            chatType: state.uri.queryParameters['chatType'],
            room: state.uri.queryParameters['room'],
            content:
                state.extra != null ? state.extra as chat_res.Content : null,
          ),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: myQuotePageRoute,
    name: myQuotePageScreenName,
    pageBuilder: (context, state) {
      return getTransition(
          child: const MyQuotesPage(),
          animationType: TransitionType.slide,
          duration: const Duration(milliseconds: 200));
    },
  ),
  GoRoute(
    path: myOrderScreenRoute,
    name: myOrderScreenName,
    pageBuilder: (context, state) {
      return getTransition(
          child: const MyOrderScreen(),
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
