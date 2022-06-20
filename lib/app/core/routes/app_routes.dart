import 'package:flutter/material.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';
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
          builder: (context) => LoginView(
            splashError: settings.arguments != null
                ? settings.arguments as String
                : null,
          ),
        );

      case AddAccountsView.routName:
        return MaterialPageRoute(
          builder: (context) => AddAccountsView(
            loggedUser: settings.arguments as LoggedUserEntity,
          ),
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
