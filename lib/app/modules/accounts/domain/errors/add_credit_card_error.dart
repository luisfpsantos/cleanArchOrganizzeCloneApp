class AddCreditCardErrors implements Exception {
  final String msg;

  AddCreditCardErrors(this.msg);
}

class InvalidArgument extends AddCreditCardErrors {
  InvalidArgument(super.msg);
}

class AddError extends AddCreditCardErrors {
  AddError(super.msg);
}

class CreditCardAlreadyExists extends AddCreditCardErrors {
  CreditCardAlreadyExists(super.msg);
}

class RepositoryError extends AddCreditCardErrors {
  RepositoryError(super.msg);
}
