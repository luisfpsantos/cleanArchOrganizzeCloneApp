import 'package:flutter/material.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view.dart';
import 'package:organizze_app/app/modules/login/presenter/views/splash_view/splash_view.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashView.routName:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );

      case LoginView.routName:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );

      case AddAccountsView.routName:
        return MaterialPageRoute(
          builder: (context) => const AddAccountsView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('PageError'),
            ),
          ),
        );
    }
  }
}
