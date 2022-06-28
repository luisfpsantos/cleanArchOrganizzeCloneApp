abstract class LoginViewEvents {}

class VerifyLoginEvent extends LoginViewEvents {
  final String user;
  final String password;
  final bool remeberMe;

  VerifyLoginEvent({
    required this.user,
    required this.password,
    required this.remeberMe,
  });
}

class SplashErrorEvent extends LoginViewEvents {
  final String msgError;

  SplashErrorEvent(this.msgError);
}

class CleanViewErrorsEvent extends LoginViewEvents {}
