import 'package:organizze_app/app/login/domain/entities/login_entity.dart';

abstract class LoginViewEvents {}

class VerifyLoginEvent extends LoginViewEvents {
  final LoginEntity login;

  VerifyLoginEvent({
    required this.login,
  });
}

class CleanViewErrorsEvent extends LoginViewEvents {}
