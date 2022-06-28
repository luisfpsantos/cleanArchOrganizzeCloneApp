abstract class VerifyUserStates {}

class VerifyUserLoading extends VerifyUserStates {}

class VerifyUserError extends VerifyUserStates {
  final String msg;

  VerifyUserError(this.msg);
}

class VerifyUserSuccess extends VerifyUserStates {}
