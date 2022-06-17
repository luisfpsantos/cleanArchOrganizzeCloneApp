class GetUserLocalErrors implements Exception {
  final String msg;

  GetUserLocalErrors(this.msg);
}

class LocalUserNotFound extends GetUserLocalErrors {
  LocalUserNotFound(super.msg);
}

class RepositoryError extends GetUserLocalErrors {
  RepositoryError(super.msg);
}
