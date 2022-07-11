import 'package:flutter/material.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';

class DashboardView extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AccountsView.routName,
                arguments: 'account',
              );
            },
            child: const Text('Contas'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Cartões'),
          ),
        ],
      ),
    );
  }
}
