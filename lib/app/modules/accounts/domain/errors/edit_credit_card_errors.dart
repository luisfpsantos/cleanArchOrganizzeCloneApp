abstract class EditCreditCardsErrors {
  final String msg;

  EditCreditCardsErrors(this.msg);
}

class EditCreditCardError extends EditCreditCardsErrors {
  EditCreditCardError(super.msg);
}

class EditCreditCardInvalidArgument extends EditCreditCardsErrors {
  EditCreditCardInvalidArgument(super.msg);
}
