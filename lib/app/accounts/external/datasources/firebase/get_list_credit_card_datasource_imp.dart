import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/credit_card_dto.dart';

class GetListCreditCardDatasourceImp implements GetListCreditCardDatasource {
  final CollectionReference _creditCardCollection;

  GetListCreditCardDatasourceImp(this._creditCardCollection);

  @override
  Future<List<CreditCardEntity>> call() async {
    List<CreditCardEntity> listCreditCards = [];

    final creditCards = await _creditCardCollection.get();

    if (creditCards.docs.isEmpty) {
      throw NoCreditCardFound('any accounts founded');
    }

    for (var creditCard in creditCards.docs) {
      listCreditCards.add(
          CreditCardDto.fromMap(creditCard.data() as Map<String, dynamic>));
    }

    return listCreditCards;
  }
}
