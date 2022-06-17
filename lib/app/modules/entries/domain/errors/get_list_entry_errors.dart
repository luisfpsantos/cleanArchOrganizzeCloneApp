class GetListEntryErrors implements Exception {
  final String msg;

  GetListEntryErrors(this.msg);
}

class NoEntryFound extends GetListEntryErrors {
  NoEntryFound(super.msg);
}

class RepositoryError extends GetListEntryErrors {
  RepositoryError(super.msg);
}
