class GetListCreditCardErros implements Exception {
  final String msg;

  GetListCreditCardErros(this.msg);
}

class NoCreditCardFound extends GetListCreditCardErros {
  NoCreditCardFound(super.msg);
}

class RepositoryError extends GetListCreditCardErros {
  RepositoryError(super.msg);
}
