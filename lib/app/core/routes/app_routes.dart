import 'package:flutter/material.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_view.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view.dart';
import 'package:organizze_app/app/modules/dashboard/views/dashboard_view/dashboard_view.dart';
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

      case DashboardView.routeName:
        return MaterialPageRoute(
          builder: (context) => const DashboardView(),
        );

      case AccountsView.routName:
        return MaterialPageRoute(
          builder: (context) => AccountsView(
            accountType: settings.arguments as String,
          ),
        );

      case SelectIconAccountView.routeName:
        return MaterialPageRoute(
          builder: (context) => const SelectIconAccountView(),
        );

      case EditAccountView.routName:
        return MaterialPageRoute(
          builder: (context) => EditAccountView(
            accountEntity: settings.arguments as AccountEntity,
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
