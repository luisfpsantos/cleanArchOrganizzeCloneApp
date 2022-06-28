class GetListCreditCardErros {
  final String msg;

  GetListCreditCardErros(this.msg);
}

class NoCreditCardFound extends GetListCreditCardErros {
  NoCreditCardFound(super.msg);
}
