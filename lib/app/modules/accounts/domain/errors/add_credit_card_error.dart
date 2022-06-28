class AddCreditCardErrors {
  final String msg;

  AddCreditCardErrors(this.msg);
}

class InvalidArgument extends AddCreditCardErrors {
  InvalidArgument(super.msg);
}

class AddCreditCardError extends AddCreditCardErrors {
  AddCreditCardError(super.msg);
}

class CreditCardAlreadyExists extends AddCreditCardErrors {
  CreditCardAlreadyExists(super.msg);
}
