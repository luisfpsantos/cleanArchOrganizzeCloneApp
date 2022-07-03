abstract class AddAccountViewStates {}

class AddAccountLoading extends AddAccountViewStates {}

class OnAddAccountError extends AddAccountViewStates {
  final String msg;

  OnAddAccountError(this.msg);
}

class AddAccountSuccess extends AddAccountViewStates {}

class AddAccountIdle extends AddAccountViewStates {}
