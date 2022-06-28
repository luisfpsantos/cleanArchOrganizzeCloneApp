class LoginErrors {
  final String msg;

  LoginErrors(this.msg);
}

class UserOrPasswordInvalid extends LoginErrors {
  UserOrPasswordInvalid(super.msg);
}

class UserNotAuthenticated extends LoginErrors {
  UserNotAuthenticated(super.msg);
}
