import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';

abstract class AddCreditCardDatasource {
  Future<bool> call(CreditCardEntity creditCard, String userId);
}
