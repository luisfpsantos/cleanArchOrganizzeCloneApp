class GetListAccountErrors {
  final String msg;

  GetListAccountErrors(this.msg);
}

class NoAccountsFound extends GetListAccountErrors {
  NoAccountsFound(super.msg);
}
