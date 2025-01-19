import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosam/features/home/home_page.dart';
import 'package:mosam/features/search/search_page.dart';
import 'package:mosam/features/splash/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: '/${RouterConstants.splashPage}',
      routes: [
        GoRoute(
          path: '/${RouterConstants.splashPage}',
          name: RouterConstants.splashPage,
          pageBuilder: (context, state) => const MaterialPage(
            child: SplashPage(),
          ),
        ),
        GoRoute(
          path: '/${RouterConstants.homePage}',
          name: RouterConstants.homePage,
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: '/${RouterConstants.searchPage}',
          name: RouterConstants.searchPage,
          pageBuilder: (context, state) => const MaterialPage(
            child: SearchPage(),
          ),
        ),
      ],
      errorBuilder: (context, state) {
        return const ErrorPage();
      });
}

class RouterConstants {
  static const String splashPage = 'splashPage';
  static const String homePage = 'homePage';
  static const String searchPage = 'searchPage';
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
