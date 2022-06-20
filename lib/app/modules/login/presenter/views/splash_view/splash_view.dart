import 'package:flutter/material.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
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
  late final VerifyLoginUsecase _verifyLogin;
  late final GetUserInDatabaseUsecase _getUserDatabase;

  @override
  void initState() {
    super.initState();
    _getUserLocal = context.read<GetUserLocalUsecase>();
    _verifyLogin = context.read<VerifyLoginUsecase>();
    _getUserDatabase = context.read<GetUserInDatabaseUsecase>();
    Future.delayed(const Duration(milliseconds: 1000), _loading);
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
      (error) => Navigator.pushReplacementNamed(context, LoginView.routName),
      (sucess) => sucess,
    );

    if (localUser is LoginEntity) {
      final verify = await _verifyLogin(localUser.user, localUser.password);
      verify.fold(
        (error) {
          Navigator.pushReplacementNamed(context, LoginView.routName);
        },
        (success) async {
          final loggedUser = await _getUserDatabase(localUser.user);
          loggedUser.fold(
            (error) => Navigator.pushReplacementNamed(
              context,
              LoginView.routName,
              arguments: 'Não foi possivel buscar usuario na base de dados',
            ),
            (success) => Navigator.pushReplacementNamed(
              context,
              AddAccountsView.routName,
              arguments: success,
            ),
          );
        },
      );
    }
  }
}
