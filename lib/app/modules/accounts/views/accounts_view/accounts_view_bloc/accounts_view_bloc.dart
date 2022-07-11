import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_states.dart';

class AccountsViewBloc extends Bloc<AccountViewEvents, AccountsViewStates> {
  final GetListAccountUsecase _getListAccountUsecase;
  final GetListCreditCardUsecase _getListCreditCardUsecase;

  AccountsViewBloc(
    this._getListAccountUsecase,
    this._getListCreditCardUsecase,
  ) : super(AccountsIdle()) {
    on<FetchAccounts>(_fetchAccounts);
  }

  Future<void> _fetchAccounts(FetchAccounts event, emit) async {
    emit(AccountsLoading());

    if (event.accountType == 'account') {
      final result = await _getListAccountUsecase(event.userId);
      result.fold(
        (error) {
          if (error is NoAccountsFound) {
            emit(AccountsNotFound(
                'Não encontrei nenhuma conta cadastrada. Adicione uma.'));
          }
        },
        (success) => emit(AccountsSuccess(success)),
      );
    }

    if (event.accountType == 'creditCard') {
      final result = await _getListCreditCardUsecase(event.userId);
      result.fold(
        (error) {
          if (error is NoAccountsFound) {
            emit(AccountsNotFound(
                'Não encontrei cartão de credito cadastrado. Adicione um.'));
          }
        },
        (success) => emit(CreditCardSuccess(success)),
      );
    }
  }
}
