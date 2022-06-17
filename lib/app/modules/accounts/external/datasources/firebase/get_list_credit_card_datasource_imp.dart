import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/credit_card_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class GetListCreditCardDatasourceImp implements GetListCreditCardDatasource {
  final FirebaseFirestore _firebaseFirestore;

  GetListCreditCardDatasourceImp(this._firebaseFirestore);

  @override
  Future<List<CreditCardEntity>> call(String userId) async {
    final creditCardCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.creditCards}',
    );

    List<CreditCardEntity> listCreditCards = [];

    final creditCards = await creditCardCollection.get();

    if (creditCards.docs.isEmpty) {
      throw NoCreditCardFound('any accounts founded');
    }

    for (var creditCard in creditCards.docs) {
      listCreditCards.add(CreditCardDto.fromMap(creditCard.data()));
    }

    return listCreditCards;
  }
}
