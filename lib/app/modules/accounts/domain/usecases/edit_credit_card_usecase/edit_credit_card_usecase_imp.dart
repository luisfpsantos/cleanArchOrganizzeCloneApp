import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_credit_card_usecase/edit_credit_card_usecase.dart';

class EditCreditCardUsecaseImp implements EditCreditCardUsecase {
  final AccountsRepository _accountsRepository;

  EditCreditCardUsecaseImp(this._accountsRepository);

  @override
  Future<Either<EditCreditCardsErrors, bool>> call(
    CreditCardEntity creditCard,
    String userID,
  ) async {
    if (creditCard.name.isEmpty) {
      return left(
          EditCreditCardInvalidArgument('name credit card is necessary'));
    }

    if (creditCard.closedDay <= 0 || creditCard.closedDay > 31) {
      return left(EditCreditCardInvalidArgument('closed day is invalid'));
    }

    if (creditCard.dueDay <= 0 || creditCard.dueDay > 31) {
      return left(EditCreditCardInvalidArgument('due day is invalid'));
    }

    if (creditCard.icon.path.isEmpty) {
      return left(EditCreditCardInvalidArgument('icon is necessary'));
    }

    if (creditCard.limit <= 0) {
      return left(EditCreditCardInvalidArgument('limit is invalid'));
    }

    return await _accountsRepository.editCreditCard(creditCard, userID);
  }
}
