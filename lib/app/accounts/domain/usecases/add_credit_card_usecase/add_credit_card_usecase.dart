import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';

abstract class AddCreditCardUsecase {
  Future<Either<AddCreditCardErrors, bool>> call(CreditCardEntity creditCard);
}
