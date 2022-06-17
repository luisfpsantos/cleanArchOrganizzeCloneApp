import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';

abstract class GetListCreditCardRepository {
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> call(
    String userId,
  );
}
