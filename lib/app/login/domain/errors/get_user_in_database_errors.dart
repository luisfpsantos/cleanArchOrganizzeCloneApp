class GetUserInDatabaseErrors implements Exception {
  final String msg;

  GetUserInDatabaseErrors(this.msg);
}

class UserNotAuthenticated extends GetUserInDatabaseErrors {
  UserNotAuthenticated(super.msg);
}

class UserNotFound extends GetUserInDatabaseErrors {
  UserNotFound(super.msg);
}

class RepositoryError extends GetUserInDatabaseErrors {
  RepositoryError(super.msg);
}
