class AddEntryErrors implements Exception {
  final String msg;

  AddEntryErrors(this.msg);
}

class InvalidArgument extends AddEntryErrors {
  InvalidArgument(super.msg);
}

class AddError extends AddEntryErrors {
  AddError(super.msg);
}

class RepositoryError extends AddEntryErrors {
  RepositoryError(super.msg);
}
