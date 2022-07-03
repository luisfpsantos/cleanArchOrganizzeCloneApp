import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_states.dart';

class AddAccountViewBloc
    extends Bloc<AddAccountViewEvents, AddAccountViewStates> {
  final AddAccountUsecase _addAccountUsecase;

  AddAccountViewBloc(this._addAccountUsecase) : super(AddAccountIdle()) {
    on<AddAccount>(_addAccount);
    on<RemoveError>(_removeError);
  }

  Future<void> _addAccount(AddAccount event, emit) async {
    emit(AddAccountLoading());
    final result = await _addAccountUsecase(event.account, event.userID);
    result.fold(
      (error) {
        if (error is InvalidArgument) {
          emit(OnAddAccountError('Nome ou icone não foi informado'));
        }
        if (error is AddAccountError) {
          emit(OnAddAccountError(
            'Erro ao adicionar conta, contate o administrador',
          ));
        }
        if (error is AccountAlreadyExists) {
          emit(OnAddAccountError('Essa conta já existe'));
        }
      },
      (success) => emit(AddAccountSuccess()),
    );
  }

  void _removeError(RemoveError event, emit) {
    emit(AddAccountIdle());
  }
}
