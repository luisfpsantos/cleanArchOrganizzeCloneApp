import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/credit_card_dto.dart';

class AddCreditCardDatasourceImp implements AddCreditCardDatasource {
  final CollectionReference _creditCardCollection;

  AddCreditCardDatasourceImp(this._creditCardCollection);

  @override
  Future<bool> call(CreditCardEntity creditCard) async {
    final query = await _creditCardCollection
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

    await _creditCardCollection
        .add(creditCardDto.toMap())
        .onError((error, _) => throw AddError('Error to add new creditCard'));

    return true;
  }
}
