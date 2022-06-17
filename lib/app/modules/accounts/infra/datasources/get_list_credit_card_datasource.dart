import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';

abstract class GetListCreditCardDatasource {
  Future<List<CreditCardEntity>> call(String userId);
}
