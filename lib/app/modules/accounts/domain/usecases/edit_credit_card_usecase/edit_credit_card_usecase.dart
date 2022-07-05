import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';

abstract class EditCreditCardUsecase {
  Future<Either<EditCreditCardsErrors, bool>> call(
    CreditCardEntity creditCard,
    String userID,
  );
}
