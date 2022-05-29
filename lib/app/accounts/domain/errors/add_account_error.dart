class AddAccountError implements Exception {
  final String msg;

  AddAccountError(this.msg);
}

class InvalidArgument extends AddAccountError {
  InvalidArgument(super.msg);
}
