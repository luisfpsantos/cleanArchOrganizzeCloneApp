abstract class EditAccountErrors {
  final String msg;

  EditAccountErrors(this.msg);
}

class EditAccountError extends EditAccountErrors {
  EditAccountError(super.msg);
}

class EditAccountInvalidArgument extends EditAccountErrors {
  EditAccountInvalidArgument(super.msg);
}
