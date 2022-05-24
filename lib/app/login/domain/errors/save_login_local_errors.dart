class SaveLoginLocalErrors implements Exception {
  final String msg;

  SaveLoginLocalErrors(this.msg);
}

class UnableToSaveLoginLocal extends SaveLoginLocalErrors {
  UnableToSaveLoginLocal(super.msg);
}

class RepositoryError extends SaveLoginLocalErrors {
  RepositoryError(super.msg);
}
