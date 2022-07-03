abstract class EditAccountViewStates {}

class EditAccountIdleState extends EditAccountViewStates {}

class EditAccountButtonEnable extends EditAccountViewStates {}

class EditAccountLoadingState extends EditAccountViewStates {}

class EditAccountErrorState extends EditAccountViewStates {
  final String msg;

  EditAccountErrorState(this.msg);
}

class EditAccountSuccessState extends EditAccountViewStates {}

class RemoveAccountSuccessState extends EditAccountViewStates {}
