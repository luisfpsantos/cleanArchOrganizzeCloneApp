class VerifyLoginErrors implements Exception {
  final String msg;

  VerifyLoginErrors(this.msg);
}

class UserOrPasswordInvalid extends VerifyLoginErrors {
  UserOrPasswordInvalid(super.msg);
}

class RepositoryError extends VerifyLoginErrors {
  RepositoryError(super.msg);
}
