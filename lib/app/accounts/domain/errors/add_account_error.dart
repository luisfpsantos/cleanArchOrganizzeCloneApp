class AddAccountError implements Exception {
  final String msg;

  AddAccountError(this.msg);
}

class InvalidArgument extends AddAccountError {
  InvalidArgument(super.msg);
}

class AddError extends AddAccountError {
  AddError(super.msg);
}

class AccountAlreadyExists extends AddAccountError {
  AccountAlreadyExists(super.msg);
}

class RepositoryError extends AddAccountError {
  RepositoryError(super.msg);
}
