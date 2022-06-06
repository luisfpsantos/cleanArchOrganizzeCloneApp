import 'package:flutter/material.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginView.routName:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
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
