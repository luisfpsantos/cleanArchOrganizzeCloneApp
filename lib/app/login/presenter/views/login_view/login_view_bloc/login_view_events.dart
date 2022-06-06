abstract class LoginViewEvents {}

class VerifyLoginEvent extends LoginViewEvents {
  final String user;
  final String password;

  VerifyLoginEvent({
    required this.user,
    required this.password,
  });
}
