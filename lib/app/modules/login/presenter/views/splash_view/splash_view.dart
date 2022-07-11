import 'package:flutter/material.dart';
import 'package:organizze_app/app/core/models/logged_user.dart';
import 'package:organizze_app/app/modules/dashboard/views/dashboard_view/dashboard_view.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  static const String routName = '/';

  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final GetUserLocalUsecase _getUserLocal;
  late final LoginUsecase _loginUsecase;

  @override
  void initState() {
    super.initState();
    _getUserLocal = context.read<GetUserLocalUsecase>();
    _loginUsecase = context.read<LoginUsecase>();
    Future.delayed(const Duration(seconds: 1), _loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                child: Image.asset(
                  'assets/images/login_icons/dollar-symbol.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const Align(
                child: SizedBox(
                  height: 200.5,
                  width: 200.5,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Organizze',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _loading() async {
    final result = await _getUserLocal();
    final localUser = result.fold(
      (error) {
        Navigator.pushReplacementNamed(context, LoginView.routName);
      },
      (sucess) => sucess,
    );

    if (localUser != null) {
      final login = await _loginUsecase(localUser.user, localUser.password);
      login.fold(
        (error) {
          Navigator.pushReplacementNamed(context, LoginView.routName);
        },
        (success) {
          context.read<LoggedUser>().name = success.name;
          context.read<LoggedUser>().accessLevel = success.accessLevel;
          context.read<LoggedUser>().authenticated = success.authenticated;
          context.read<LoggedUser>().user = success.user;
          context.read<LoggedUser>().userId = success.userId;

          Navigator.pushReplacementNamed(context, DashboardView.routeName);
        },
      );
    }
  }
}
