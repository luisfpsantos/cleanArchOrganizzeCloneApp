class AddAccountErrors {
  final String msg;

  AddAccountErrors(this.msg);
}

class InvalidArgument extends AddAccountErrors {
  InvalidArgument(super.msg);
}

class AddAccountError extends AddAccountErrors {
  AddAccountError(super.msg);
}

class AccountAlreadyExists extends AddAccountErrors {
  AccountAlreadyExists(super.msg);
}
