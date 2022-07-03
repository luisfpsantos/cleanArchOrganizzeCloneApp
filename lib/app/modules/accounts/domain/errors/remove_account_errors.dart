abstract class RemoveAccountErrors {
  final String msg;

  RemoveAccountErrors(this.msg);
}

class RemoveAccountError extends RemoveAccountErrors {
  RemoveAccountError(super.msg);
}
