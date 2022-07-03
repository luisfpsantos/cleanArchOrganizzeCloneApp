import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_states.dart';

class EditAccountViewBloc
    extends Bloc<EditAccountViewEvents, EditAccountViewStates> {
  final EditAccountUsecase _editAccountUsecase;
  final RemoveAccountUsecase _removeAccountUsecase;

  EditAccountViewBloc(
    this._editAccountUsecase,
    this._removeAccountUsecase,
  ) : super(EditAccountIdleState()) {
    on<OnEditAccountEvent>(_editAccount);
    on<OnEditAccountChangeEvent>(_onEditChangeEvent);
    on<ToEditAccountDefault>(_toEditAccountDefault);
    on<OnRemoveAccountEvent>(_onRemoveAccount);
  }

  Future<void> _editAccount(OnEditAccountEvent event, emit) async {
    emit(EditAccountLoadingState());

    final result = await _editAccountUsecase(event.account, event.userId);
    result.fold(
      (error) {
        if (error is EditAccountInvalidArgument) {
          emit(EditAccountErrorState('Nome ou icone é invalido'));
        }
        if (error is EditAccountError) {
          emit(EditAccountErrorState('Erro ao editar a conta'));
        }
      },
      (sucess) => emit(EditAccountSuccessState()),
    );
  }

  void _onEditChangeEvent(event, emit) {
    emit(EditAccountButtonEnable());
  }

  void _toEditAccountDefault(event, emit) {
    emit(EditAccountIdleState());
  }

  Future<void> _onRemoveAccount(OnRemoveAccountEvent event, emit) async {
    emit(EditAccountLoadingState());
    final result = await _removeAccountUsecase(event.userId, event.accountId);

    result.fold(
      (error) => emit(
        EditAccountErrorState('Não foi possivel deletar a conta'),
      ),
      (sucess) => emit(RemoveAccountSuccessState()),
    );
  }
}
