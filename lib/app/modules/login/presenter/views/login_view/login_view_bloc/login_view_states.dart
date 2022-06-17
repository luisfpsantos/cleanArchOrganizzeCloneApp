abstract class LoginViewStates {}

class LoginIdle extends LoginViewStates {}

class LoginLoading extends LoginViewStates {}

class LoginError extends LoginViewStates {
  final String msg;

  LoginError(this.msg);
}

class LoginSuccess extends LoginViewStates {}
