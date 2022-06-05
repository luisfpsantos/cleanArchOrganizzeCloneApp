import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_credit_card_erros.dart';

abstract class GetListCreditCardUsecase {
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> call(
    String userId,
  );
}
