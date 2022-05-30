import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/domain/repositories/add_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';

class AddCreditCardUsecaseImp implements AddCreditCardUsecase {
  final AddCreditCardRepository _addCreditCardRepository;

  AddCreditCardUsecaseImp(this._addCreditCardRepository);

  @override
  Future<Either<AddCreditCardErrors, bool>> call(
    CreditCardEntity creditCard,
  ) async {
    if (creditCard.name.isEmpty) {
      return left(InvalidArgument('name credit card is necessary'));
    }

    if (creditCard.closedDay <= 0 || creditCard.closedDay > 31) {
      return left(InvalidArgument('closed day is invalid'));
    }

    if (creditCard.dueDay <= 0 || creditCard.dueDay > 31) {
      return left(InvalidArgument('due day is invalid'));
    }

    if (creditCard.iconPath.isEmpty) {
      return left(InvalidArgument('icon is necessary'));
    }

    if (creditCard.limit <= 0) {
      return left(InvalidArgument('limit is invalid'));
    }

    return await _addCreditCardRepository(creditCard);
  }
}
