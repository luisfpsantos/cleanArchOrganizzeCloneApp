class GetListAccountErrors implements Exception {
  final String msg;

  GetListAccountErrors(this.msg);
}

class NoAccountsFound extends GetListAccountErrors {
  NoAccountsFound(super.msg);
}

class RepositoryError extends GetListAccountErrors {
  RepositoryError(super.msg);
}
