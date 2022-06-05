import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/credit_card_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class AddCreditCardDatasourceImp implements AddCreditCardDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddCreditCardDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(CreditCardEntity creditCard, String userId) async {
    final creditCardCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.creditCards}',
    );

    final query = await creditCardCollection
        .where('name', isEqualTo: creditCard.name)
        .get();

    if (query.docs.isNotEmpty) {
      throw CreditCardAlreadyExists('Credit card already exists');
    }

    final creditCardDto = CreditCardDto(
      closedDay: creditCard.closedDay,
      dueDay: creditCard.dueDay,
      iconPath: creditCard.iconPath,
      limit: creditCard.limit,
      name: creditCard.name,
    );

    await creditCardCollection
        .add(creditCardDto.toMap())
        .onError((error, _) => throw AddError('Error to add new creditCard'));

    return true;
  }
}
