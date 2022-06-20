import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';

abstract class LoginViewStates {}

class LoginIdle extends LoginViewStates {}

class LoginLoading extends LoginViewStates {}

class LoginError extends LoginViewStates {
  final String msg;

  LoginError(this.msg);
}

class LoginSuccess extends LoginViewStates {
  final LoggedUserEntity loggedUser;

  LoginSuccess(this.loggedUser);
}
