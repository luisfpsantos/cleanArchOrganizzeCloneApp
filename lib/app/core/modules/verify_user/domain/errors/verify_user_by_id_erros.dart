class VerifyUserByIdErrors {
  final String msg;

  VerifyUserByIdErrors(this.msg);
}

class UserNotAuthenticated extends VerifyUserByIdErrors {
  UserNotAuthenticated(super.msg);
}

class UserNotFound extends VerifyUserByIdErrors {
  UserNotFound(super.msg);
}
