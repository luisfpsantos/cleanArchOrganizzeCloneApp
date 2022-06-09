import 'package:organizze_app/app/login/domain/entities/login_entity.dart';

abstract class LoginViewEvents {}

class VerifyLoginEvent extends LoginViewEvents {
  final String user;
  final String password;

  VerifyLoginEvent({
    required this.user,
    required this.password,
  });
}

class CleanViewErrorsEvent extends LoginViewEvents {}

class SaveLoginLocalEvent extends LoginViewEvents {
  final LoginEntity login;

  SaveLoginLocalEvent(this.login);
}
